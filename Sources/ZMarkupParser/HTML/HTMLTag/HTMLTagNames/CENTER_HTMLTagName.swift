//
//  CENTER_HTMLTagName.swift
//  
//
//  Created by 오준현 on 2023/08/08.
//

import Foundation

public struct CENTER_HTMLTagName: HTMLTagName {
    public let string: String = WC3HTMLTagName.center.rawValue

    public init() {

    }

    public func accept<V>(_ visitor: V) -> V.Result where V : HTMLTagNameVisitor {
        return visitor.visit(self)
    }
}
