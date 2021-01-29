//
//  LayoutTextView.swift
//  Jikan
//
//  Created by CHI on 2021/1/15.
//

import UIKit

class LayoutTextView: UITextView {
    var minWordLimit: Int = 0
    var maxWordLimit: Int = .max
    
    var isConformToWordLimit: Bool {
        return (text?.count ?? 0) >= minWordLimit && (text?.count ?? 0) <= maxWordLimit
    }
    
    init(textColor: UIColor?, font: UIFont, textAlignment: NSTextAlignment = .left, tinitColor: UIColor? = nil) {
        super.init(frame: .zero, textContainer: nil)
        translatesAutoresizingMaskIntoConstraints = false
        
        self.font = font
        self.textAlignment = textAlignment
        
        if let textColor = textColor {
            self.textColor = textColor
        }
        
        if let tintColor = tintColor {
            self.tintColor = tintColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
