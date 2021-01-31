//
//  TypePickerCollectionViewFlowLayout.swift
//  Jikan
//
//  Created by CHI on 2021/1/31.
//

import UIKit

class TypePickerCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        minimumLineSpacing = 12.basedOnScreenWidth()
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 44.basedOnScreenWidth())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        sectionInset = UIEdgeInsets(top: 0, left: 12.basedOnScreenWidth(), bottom: 0, right: 12.basedOnScreenWidth())
        
        let attributes = super.layoutAttributesForElements(in: rect)
     
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.representedElementCategory == .cell {
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }
                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width + 8.basedOnScreenWidth()
                maxY = max(layoutAttribute.frame.maxY, maxY)
            }
        }
        return attributes
    }
}
