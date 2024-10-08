//
//  AllToolsJSONStringSyntax.swift
//
//
//  Created by 伊藤史 on 2024/05/24.
//

import Foundation
import Mustache
import CommonModules

/// An enumeration for rendering json string of all tools using a specified template.
enum AllToolsJSONStringSyntax {
    /// Renders json string of the all tools using the given template type.
    /// - Parameters:
    ///   - templateObject: An array of `FunctionTool` objects to be rendered.
    ///   - service: The `FunctionCallingService` used for the tool container.
    /// - Throws: An error if the rendering fails.
    /// - Returns: A `String` representation of the rendered tools.
    static func render(
        with templateObject: [FunctionTool],
        service: FunctionCallingService
    ) throws -> String {
        return try AllToolsJSONStringTemplate.render(with: templateObject, service: service)
    }
}
