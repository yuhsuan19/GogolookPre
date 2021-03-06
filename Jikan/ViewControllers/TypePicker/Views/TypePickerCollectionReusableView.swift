//
//  TypePickerCollectionReusableView.swift
//  Jikan
//
//  Created by CHI on 2021/1/31.
//

import UIKit

class TypePickerCollectionReusableView: UICollectionReusableView {
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    lazy var titleLabel = LayoutLabel(textColor: .tertiaryLabel, fontSize: 12.basedOnScreenWidth(), fontWeight: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAndLayoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpAndLayoutViews() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.basedOnScreenWidth()),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5.basedOnScreenWidth()),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5.basedOnScreenWidth())
        ])
    }
}
