//
//  FunctionTool.swift
//  
//
//  Created by 伊藤史 on 2024/08/08.
//

import Foundation
// TODO: swift doc書く
public enum FunctionToolType: String, Codable {
    case function
    case none

    init(fromService service: FunctionCallingService) {
        switch service {
        case .claude:
            self = .none
        case .chatGPT:
            self = .function
        }
    }
}

public struct FunctionTool {
    public let service: FunctionCallingService
    public let type: FunctionToolType
    public let function: Tool

    public init(service: FunctionCallingService, function: Tool) {
        self.service = service
        self.type = FunctionToolType(fromService: service)
        self.function = function
    }

    // TODO: この辺にchat gptのjson構造とそのリンクを貼る
    enum ChatGPTCodingKeys: String, CodingKey {
        case type
        case function
    }
}

extension FunctionTool: Encodable {
    public func encode(to encoder: any Encoder) throws {
        switch service {
        case .claude:
            // TODO: この辺にclaudeのjson構造とそのリンクを貼る
            var container = encoder.singleValueContainer()
            try container.encode(function)
        case .chatGPT:
            var container = encoder.container(keyedBy: ChatGPTCodingKeys.self)
            try container.encode(type, forKey: .type)
            try container.encode(function, forKey: .function)
        }
    }
}

extension FunctionTool: Decodable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: ChatGPTCodingKeys.self)
        if let tool = try? container.decode(Tool.self, forKey: .function) {
            self.service = .chatGPT
            self.type = .function
            self.function = tool
        } else {
            self.service = .claude
            self.type = .none

            let singleValueContainer = try decoder.singleValueContainer()
            self.function = try singleValueContainer.decode(Tool.self)
        }
    }
}
