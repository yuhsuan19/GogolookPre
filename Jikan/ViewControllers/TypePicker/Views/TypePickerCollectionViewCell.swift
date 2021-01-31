//
//  TypePickerCollectionViewCell.swift
//  Jikan
//
//  Created by CHI on 2021/1/31.
//

import UIKit

class TypePickerCollectionViewCell: BasedCollectionViewCell {
    var isPicked: Bool = false {
        didSet {
            label.textColor = isPicked ? .systemBlue : .secondaryLabel
            layer.borderColor = isPicked ? UIColor.systemBlue.cgColor : UIColor.secondaryLabel.cgColor
        }
    }
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    lazy var label = LayoutLabel(text: text, textColor: .secondaryLabel, textAlignment: .center, fontSize: 14.basedOnScreenWidth())
    
    // MARK: Object life cycle
    override func setUpAndLayoutViews() {
        super.setUpAndLayoutViews()
        
        layer.borderWidth = max(1, 1.basedOnScreenWidth())
        layer.borderColor = UIColor.secondaryLabel.cgColor
        
        addObservedKeyPath(#keyPath(bounds)) { [weak self] in
            self?.roundBorder()
        }
        
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11.basedOnScreenWidth()),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11.basedOnScreenWidth()),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13.basedOnScreenWidth()),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -13.basedOnScreenWidth())
        ])
    }
    
    private func roundBorder() {
        layer.cornerRadius = bounds.height / 2
    }
}
