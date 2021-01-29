//
//  Encodable.swift
//  Jikan
//
//  Created by CHI on 2021/1/15.
//

import Foundation

extension Encodable {
    var dataValue: Data? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return data
    }
}
