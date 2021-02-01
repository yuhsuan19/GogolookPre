//
//  AnimeDocument.swift
//  Jikan
//
//  Created by CHI on 2021/2/1.
//

import Foundation
import SwiftyJSON
import CouchbaseLiteSwift

class AnimeDocument {
    static let type = "Anime"

    var document = MutableDocument()
    
    init(document: Document) {
        self.document = document.toMutable()
    }

    init?(anime: Anime) {
        document.setInt64(anime.mal_id, forKey: "mal_id")
        document.setString(AnimeDocument.type, forKey: "type")
        
        if let josnData = try? JSONEncoder().encode(anime),
            let json = try? JSON(data: josnData).rawString() {
            self.json = json
        } else {
            return nil
        }
    }
    
    var json: String? {
        get {
            document.string(forKey: "json")
        }
        set {
            document.setString(newValue, forKey: "json")
        }
    }
    
    var anime: Anime? {
        get {
            guard let rawString = json else {
                return nil
            }
            guard let jsonData = try? JSON(parseJSON: rawString).rawData(),
                let anime = try?  JSONDecoder().decode(Anime.self, from: jsonData) else {
                    return nil
            }
            return anime
        }
    }
    
    func save() {
        do {
            try CouchbaseDBManager.shared.database?.saveDocument(document)
        } catch {
            print("Save anime document failed: \(error.localizedDescription)")
        }
    }
    
    func delete() {
        do {
            try CouchbaseDBManager.shared.database?.deleteDocument(document)
        } catch {
            print("Delete anime document failed: \(error.localizedDescription)")
        }
    }
}

extension AnimeDocument {
    static func fetchLocalAnimes() -> [Anime] {
        guard let database = CouchbaseDBManager.shared.database else {
            return []
        }
        
        let query = QueryBuilder
            .select(SelectResult.expression(Meta.id))
            .from(DataSource.database(database))
            .where(Expression.property("type").equalTo(Expression.string(AnimeDocument.type)))
        
        do {
            var animes: [Anime] = []
            for result in try query.execute() {
                if let documentId = result.string(forKey: "id"),
                    let document = database.document(withID: documentId),
                    let anime = AnimeDocument(document: document).anime {
                    animes.append(anime)
                }
            }
            return animes
        } catch {
            print(error)
            return []
        }
    }
    
    static func deleteLocalAnime(with id: Int64) {
        guard let database = CouchbaseDBManager.shared.database else {
            return
        }
        
        let query = QueryBuilder
            .select(SelectResult.expression(Meta.id))
            .from(DataSource.database(database))
            .where(
                Expression.property("mal_id").equalTo(Expression.int64(id))
                .and(Expression.property("type").equalTo(Expression.string(AnimeDocument.type)))
            )
        do {
            for result in try query.execute() {
                if let documentId = result.string(forKey: "id"),
                    let document = database.document(withID: documentId) {
                    let animeDocument = AnimeDocument(document: document)
                    animeDocument.delete()
                }
            }
        } catch {
            print(error)
        }
    }
    
    static func fetchLocalAnime(with id: Int64) -> Anime? {
        guard let database = CouchbaseDBManager.shared.database else {
            return nil
        }
        
        let query = QueryBuilder
            .select(SelectResult.expression(Meta.id))
            .from(DataSource.database(database))
            .where(
                Expression.property("mal_id").equalTo(Expression.int64(id))
                .and(Expression.property("type").equalTo(Expression.string(AnimeDocument.type)))
            )
            
        do {
            for result in try query.execute() {
                if let documentId = result.string(forKey: "id"),
                   let document = database.document(withID: documentId) {
                    let animeDocument = AnimeDocument(document: document)
                    return animeDocument.anime
                }
            }
        } catch {
            print(error)
            return nil
        }
        
        return nil
    }
    
    static func cleanLocalAnimes() {
        guard let database = CouchbaseDBManager.shared.database else {
            return
        }
        let query = QueryBuilder
            .select(SelectResult.expression(Meta.id))
            .from(DataSource.database(database))
            .where(Expression.property("type").equalTo(Expression.string(AnimeDocument.type)))
        
        do {
            for result in try query.execute() {
                if let documentId = result.string(forKey: "id"),
                    let document = database.document(withID: documentId) {
                    let animeDocument = AnimeDocument(document: document)
                    animeDocument.delete()
                }
            }
        } catch {
            print(error)
        }
    }
}
