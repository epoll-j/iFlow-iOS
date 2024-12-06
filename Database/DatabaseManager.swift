//
//  DatabaseManager.swift
//  Database
//
//  Created by dubhe on 2024/12/6.
//

import Foundation
import SQLite

public class DatabaseManager {
    public static let shared = DatabaseManager()
    
    private let db: Connection
    
    private init?() {
        do {
            // 设置数据库路径
            let fileManager = FileManager.default
            let documentsURL = try fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            let dbURL = documentsURL.appendingPathComponent("database.sqlite3")
            db = try Connection(dbURL.path)
        } catch {
            print("Unable to open database: \(error)")
            return nil
        }
    }
    
    func connection() -> Connection {
        return db
    }
}
