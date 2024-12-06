//
//  HostFilterTable.swift
//  Database
//
//  Created by dubhe on 2024/12/6.
//

import Foundation
import SQLite

public struct HostFilter {
    public let id: Int64
    public let host: String
    public let type: Int
    
    public init(id: Int64, host: String, type: Int) {
        self.id = id
        self.host = host
        self.type = type
    }
}


public class HostFilterTable: DatabaseTable {
    
    typealias ModelType = HostFilter
    
    let table = Table("host_filter")
    let id = Expression<Int64>("id")
    let host = Expression<String>("host")
    let type = Expression<Int>("type")
    
    public init() {
        try? createTable()
    }
    
    func createTable() throws {
        try DatabaseManager.shared?.connection().run(table.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(host)
            t.column(type)
        })
    }
    
    public func insert(model: HostFilter) throws {
        let insert = table.insert(host <- model.host, type <- model.type)
        
        try DatabaseManager.shared?.connection().run(insert)
    }
    
    func fetchAll() throws -> [HostFilter] {
        var hosts = [HostFilter]()
        
        for h in try DatabaseManager.shared!.connection().prepare(table) {
            hosts.append(HostFilter(id: h[id], host: h[host], type: h[type]))
        }
        
        return hosts
    }
    
    public func fetchByType(_ searchType: Int) throws -> [HostFilter] {
        var hosts = [HostFilter]()
        
        for h in try DatabaseManager.shared!.connection().prepare(table.filter(self.type == searchType)) {
            hosts.append(HostFilter(id: h[id], host: h[host], type: h[type]))
        }
        
        return hosts
    }
    
}
