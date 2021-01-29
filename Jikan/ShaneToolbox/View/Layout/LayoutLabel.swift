//
//  LayoutLabel.swift
//  Jikan
//
//  Created by CHI on 2021/1/14.
//

import UIKit

class LayoutLabel: UILabel {
    init(text: String? = nil, textColor: UIColor, textAlignment: NSTextAlignment = .left, fontSize: CGFloat, fontWeight: UIFont.Weight = .regular) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
