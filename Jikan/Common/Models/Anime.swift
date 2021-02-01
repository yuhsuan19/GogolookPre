//
//  Anime.swift
//  Jikan
//
//  Created by CHI on 2021/1/30.
//

import Foundation

struct Anime: Codable, Equatable {
    var mal_id: Int64
    var image_url: String?
    var url: String?
    var title: String
    var rank: Int
    var start_date: String?
    var end_date: String?
    var type: String
    
    var imageURL: URL? {
        guard let urlString = image_url else {
            return nil
        }
        return URL(string: urlString)
    }
    
    var contentURL: URL? {
        guard let urlString = url else {
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
    
    var isFavorite: Bool {
        return !(AnimeDocument.fetchLocalAnime(with: mal_id) == nil)
    }
}

extension Anime {
    enum MainType: String {
        case anime = "anime"
        case manga = "manga"
        
        var text: String {
            switch self {
            case .anime:
                return "Anime"
            case .manga:
                return "Manga"
            }
        }
    }
    
    enum SubType: String {
        // anime
        case airing = "airing"
        case upcoming = "upcoming"
        case tv = "tv"
        case movie = "movie"
        case ova = "ova"
        case special = "special"
        // manga
        case manga = "manga"
        case novels = "novels"
        case oneshots = "oneshots"
        case doujin = "doujin"
        case manhwa = "manhwa"
        case manhua = "manhua"
        // both
        case bypopularity = "bypopularity"
        case favorite = "favorite"
        
        var text: String {
            switch self {
            case .airing:
                return "Airing"
            case .upcoming:
                return "Upcoming"
            case .tv:
                return "TV"
            case .movie:
                return "Movie"
            case .ova:
                return "OVA"
            case .special:
                return "Special"
            case .manga:
                return "Manga"
            case .novels:
                return "Novels"
            case .oneshots:
                return "One-shots"
            case .doujin:
                return "Doujin"
            case .manhwa:
                return "Manhwa"
            case .manhua:
                return "Manhua"
            case .bypopularity:
                return "By popularity"
            case .favorite:
                return "Favorite"
            }
        }
    }
    
}
