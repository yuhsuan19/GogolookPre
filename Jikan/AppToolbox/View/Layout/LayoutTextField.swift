//
//  LayoutTextField.swift
//  Jikan
//
//  Created by CHI on 2021/1/15.
//

import UIKit

class LayoutTextField: UITextField {
    
    var minWordLimit: Int = 0
    var maxWordLimit: Int = .max
    
    var isConformToWordLimit: Bool {
        return (text?.count ?? 0) >= minWordLimit && (text?.count ?? 0) <= maxWordLimit
    }
    
    init(keyboard: UIKeyboardType = .default, textColor: UIColor?, font: UIFont, textAlignment: NSTextAlignment = .left, tinitColor: UIColor? = nil, placeholder: String? = nil) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        keyboardType = keyboard
        self.font = font
        self.textAlignment = textAlignment
        self.placeholder = placeholder
        
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
