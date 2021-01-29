//
//  ArrayExtension.swift
//  Jikan
//
//  Created by CHI on 2021/1/14.
//

import Foundation

extension Array {
    var lastElementIndex: Int {
        return isEmpty ? 0 : count - 1
    }
}
