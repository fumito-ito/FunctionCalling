//
//  FunctionTools.swift
//
//
//  Created by Fumito Ito on 2024/08/07.
//

import Foundation
import CommonModules

extension FunctionTool {
    init(from decl: FunctionDeclaration, service: FunctionCallingService) throws {
        self.init(
            service: service,
            function: try .init(from: decl, service: service)
        )
    }
}
