//
//  CallableFunctionMacro.swift
//
//
//  Created by 伊藤史 on 2024/04/28.
//

import SwiftSyntax
import SwiftSyntaxMacros

/// A structure representing a macro that marks methods as callable functions.
///
/// This is just an annotation to detect which method should be callable.
public struct CallableFunctionMacro: PeerMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        // This is just an annotation to detect which method should be callable.
        return []
    }
}
