//
//  ToolContainerSyntaxTests.swift
//  
//
//  Created by Fumito Ito on 2024/06/03.
//

import XCTest
import SwiftSyntax
import SwiftParser
import CommonModules
@testable import SyntaxRenderer

final class ToolContainerSyntaxTests: XCTestCase {
    static let getHTML = Function(
        methodName: "getHTML",
        parameters: [
            Parameter(name: "urlString", omittingName: nil, required: true, type: "String", isLast: true)
        ],
        isStatic: true
    )

    static func generateGetHTMLTool(isLast: Bool) -> Tool {
        .init(
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

    // swiftlint:disable:next function_body_length
    func testGenerateSyntaxFromObject() throws {
        let execute = try ExecuteSyntax.render(with: Execute(functions: [Self.getHTML]))
        let allTools = try AllToolsSyntax.render(
            with: [Self.generateGetHTMLTool(isLast: true)],
            templateType: .claude
        )
        let model = ToolContainerExtension(type: "Sample", executeSyntax: execute, allToolsSyntax: allTools)
        let filledTemplate = try ToolContainerExtensionSyntax.render(from: model).description
        let lines = filledTemplate.split(separator: "\n")

        XCTAssertEqual(lines.first, "extension Sample: ToolContainer {")
        XCTAssertEqual(lines.last, "}")
    }
}
