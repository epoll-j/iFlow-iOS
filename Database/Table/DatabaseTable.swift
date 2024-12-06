//
//  DatabaseTable.swift
//  Database
//
//  Created by dubhe on 2024/12/6.
//

import SQLite

protocol DatabaseTable {
    associatedtype ModelType
    
    var table: Table { get }
    
    func createTable() throws
    func insert(model: ModelType) throws
    func fetchAll() throws -> [ModelType]
}
