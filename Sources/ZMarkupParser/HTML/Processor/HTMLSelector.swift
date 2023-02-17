//
//  HTMLSelector.swift
//  
//
//  Created by https://zhgchg.li on 2023/2/17.
//

import Foundation

public class HTMLTagSelecor: HTMLSelector {
    public let tagName: HTMLTagName
    public let tagAttributedString: NSAttributedString
    public let attributes: [String: String]?
    
    init(tagName: HTMLTagName, tagAttributedString: NSAttributedString, attributes: [String : String]?) {
        self.tagName = tagName
        self.tagAttributedString = tagAttributedString
        self.attributes = attributes
    }
}

public class HTMLTagContentSelecor: HTMLSelector {
    let _attributedString: NSAttributedString
    
    init(attributedString: NSAttributedString) {
        self._attributedString = attributedString
    }
}

public class RootHTMLSelecor: HTMLSelector {
    
}

public class HTMLSelector {
    
    public private(set) var parent: HTMLSelector? = nil
    public private(set) var childSelectors: [HTMLSelector] = []
    
    func appendChild(selector: HTMLSelector) {
        selector.parent = self
        childSelectors.append(selector)
    }
    
    public func filter(_ htmlTagName: HTMLTagName) -> [HTMLSelector] {
        return self.filter(htmlTagName.string)
    }
    
    public func filter(_ htmlTagName: String) -> [HTMLSelector] {
        return childSelectors.compactMap({ $0 as? HTMLTagSelecor }).filter({ $0.tagName.isEqualTo(htmlTagName) })
    }
    
    public func first(_ htmlTagName: HTMLTagName) -> HTMLSelector? {
        return self.filter(htmlTagName).first
    }
    
    public func first(_ htmlTagName: String) -> HTMLSelector? {
        return self.filter(htmlTagName).first
    }
}

extension HTMLSelector {
    public var attributedString: NSAttributedString {
        return attributedString(self)
    }
    
    private func attributedString(_ selector: HTMLSelector) -> NSAttributedString {
        if let contentSelector = selector as? HTMLTagContentSelecor {
            return contentSelector._attributedString
        } else {
            return selector.childSelectors.compactMap({ attributedString($0) }).reduce(NSMutableAttributedString()) { partialResult, attributedString in
                partialResult.append(attributedString)
                return partialResult
            }
        }
    }
}
