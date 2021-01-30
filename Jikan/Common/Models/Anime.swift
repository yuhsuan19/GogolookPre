//
//  Anime.swift
//  Jikan
//
//  Created by CHI on 2021/1/30.
//

import Foundation

struct Anime: Codable {
    var image_url: String?
    var url: String?
    var title: String
    var rank: Int
    var start_date: String
    var end_date: String?
    var type: String
    
    var imageURL: URL? {
        guard let urlString = image_url else {
            return nil
        }
        return URL(string: urlString)
    }
    
    var contentURL: URL? {
        guard let urlString = image_url else {
            return nil
        }
        return URL(string: urlString)
    }
    
    var rankText: String {
        let formatter =  NumberFormatter()
        formatter.numberStyle = .ordinal
        let text = formatter.string(from: NSNumber(value: rank)) ?? "-"
        return text
    }
}
