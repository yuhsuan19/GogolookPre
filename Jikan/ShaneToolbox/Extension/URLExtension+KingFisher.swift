//
//  URLExtension+KingFisher.swift
//  Jikan
//
//  Created by CHI on 2021/1/15.
//

import Foundation
import Kingfisher

extension URL {
    var imageResource: ImageResource {
        let cacheKey = "\(self).thumbnail"
        return ImageResource(downloadURL: self, cacheKey: cacheKey)
    }
}
