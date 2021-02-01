//
//  CouchbaseDBManager.swift
//  Jikan
//
//  Created by CHI on 2021/2/1.
//

import Foundation
import CouchbaseLiteSwift

class CouchbaseDBManager {
    static let appDatabaseName = "JikanCouchbaseDB"
    
    static let shared = CouchbaseDBManager()
    
    let database: Database?
    
    init() {
        database = try? Database(name: CouchbaseDBManager.appDatabaseName)
    }
    
    func saveToDocument(mutableDoc: MutableDocument) -> Bool {
        guard let db = database else {
            return false
        }
        do {
            try db.saveDocument(mutableDoc)
            return true
        } catch {
            return false
        }
    }
}
