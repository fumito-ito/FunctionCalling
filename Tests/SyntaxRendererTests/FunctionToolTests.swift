//
//  FunctionToolTests.swift
//
//
//  Created by Fumito Ito on 2024/08/07.
//

import XCTest
import CommonModules
@testable import SyntaxRenderer

final class FunctionToolTests: XCTestCase {
    static var getHTML: Tool {
        .init(
            service: .claude,
            name: "getHTML",
            description: "This is description for `getHTML` method.",
            inputSchema: .init(
                type: .object,
                properties: [
                    "urlString": .init(
                        type: .string,
                        description: "This is description for `urlString` property",
                        nullable: false
                    )
                ],
                requiredProperties: [
                    "urlString"
                ]
            )
        )
    }

    static var timeOfDay: Tool {
        .init(
            service: .claude,
            name: "timeOfDay",
            description: "This is description for `timeOfDay` method.",
            inputSchema: .init(
                type: .object,
                properties: [
                    "timeZone": .init(
                        type: .string,
                        description: "This is description for `timeOfDay` property",
                        nullable: false
                    ),
                    "DST": .init(
                        type: .string,
                        description: "This is description for `DST` property",
                        nullable: true
                    )
                ],
                requiredProperties: [
                    "timeZone"
                ]
            )
        )
    }

    func testEncodingFunctionForClaude() throws {
        let tool = FunctionTool(service: .claude, function: Self.getHTML)
        let jsonData = try FunctionCallingEncoder.encode(tool)
        if let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
            XCTAssertEqual(dictionary["name"] as! String, "getHTML")
            // TODO: fil test
        } else {
            XCTFail()
        }
    }

    func testEncodingFunctionsForClaude() throws {
        let tools = [
            FunctionTool(service: .claude, function: Self.getHTML),
            FunctionTool(service: .claude, function: Self.timeOfDay)
        ]
        let jsonData = try FunctionCallingEncoder.encode(tools)
        if let array = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] {
            XCTAssertEqual(array.count, 2)
            // TODO: fil test
        } else {
            XCTFail()
        }
    }

    func testEncodingFunctionForChatGPT() throws {
        let tool = FunctionTool(service: .chatGPT, function: Self.getHTML)
        let jsonData = try FunctionCallingEncoder.encode(tool)
        if let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
            XCTAssertEqual(dictionary["type"] as! String, "function")
            let tool = try XCTUnwrap(dictionary["function"] as? [String: Any])
            XCTAssertEqual(tool["name"] as? String, "getHTML")
            // TODO: fil test
        } else {
            XCTFail()
        }
    }

    func testEncodingFunctionsForChatGPT() throws {
        let tools = [
            FunctionTool(service: .chatGPT, function: Self.getHTML),
            FunctionTool(service: .chatGPT, function: Self.timeOfDay)
        ]
        let jsonData = try FunctionCallingEncoder.encode(tools)
        if let array = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] {
            XCTAssertEqual(array.count, 2)
            // TODO: fil test
        } else {
            XCTFail()
        }
    }

    func testDecodingClaude() throws {
        let tool = FunctionTool(service: .claude, function: Self.getHTML)
        let jsonData = try FunctionCallingEncoder.encode(tool)
        let result = try FunctionCallingDecoder.decode(FunctionTool.self, from: jsonData)

        XCTAssertEqual(result.service, .claude)
        XCTAssertEqual(result.type, .none)
        XCTAssertEqual(result.function.name, "getHTML")
        // TODO: fil tests
    }

    func testDecodingChatGPT() throws {
        let tool = FunctionTool(service: .chatGPT, function: Self.getHTML)
        let jsonData = try FunctionCallingEncoder.encode(tool)
        let result = try FunctionCallingDecoder.decode(FunctionTool.self, from: jsonData)

        XCTAssertEqual(result.service, .chatGPT)
        XCTAssertEqual(result.type, .function)
        XCTAssertEqual(result.function.name, "getHTML")
        // TODO: fil tests
    }
}
