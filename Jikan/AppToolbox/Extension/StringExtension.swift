//
//  StringExtension.swift
//  Jikan
//
//  Created by CHI on 2021/1/15.
//

import Foundation
import UIKit
extension String {
    
    func lineSpaced(_ spacing: CGFloat, alignment: NSTextAlignment = .left, textColor: UIColor? = nil, font: UIFont?) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = alignment
        
        var attributes: [NSAttributedString.Key: Any] = [.paragraphStyle: paragraphStyle]
        if let textColor = textColor {
            attributes[.foregroundColor] = textColor
        }
        if let font = font {
            attributes[.font] = font
        }
        
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    // 以半形文字為單位計算的字串長度
    var halfWidthUnitLength: Int {
        var length: Int = 0
        for character in self {
            let originChar = NSString(string: "\(character)")
            if let fullWidthChar = originChar.applyingTransform(.fullwidthToHalfwidth, reverse: true) {
                (fullWidthChar == "\(character)") ? (length += 2) : (length += 1)
            } else {
                length += 1
            }
        }
        return length
    }
    
    // MARK: Format checking
    func isValidEmailFormat() -> Bool {
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        return emailPredicate.evaluate(with: self)
    }
}
