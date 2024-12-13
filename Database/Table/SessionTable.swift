//
//  SessionTable.swift
//  Database
//
//  Created by dubhe on 2024/12/10.
//

import Foundation
import SQLite

public struct Session {
    public var id: Int64
    public var taskId: Int64?
    public var remoteAddress: String?
    public var localAddress: String?
    public var host: String?
    public var schemes: String?
    public var requestLine: String?
    public var methods: String?
    public var uri: String?
    public var suffix: String?
    
    public var requestContentType: String?
    public var requestContentEncoding: String?
    public var requestHeader: String?
    public var requestHttpVersion: String?
    public var requestBody: String?
    
    public var target: String?
    public var httpCode: String?
    
    public var responseContentType: String?
    public var responseContentEncoding: String?
    public var responseHeader: String?
    public var responseHttpVersion: String?
    public var responseBody: String?
    public var responseMsg: String?
    
    public var startTime: Double?
    public var connectTime: Double?
    public var connectedTime: Double?
    public var handshakeTime: Double?
    public var requestEndTime: Double?
    public var responseStartTime: Double?
    public var responseEndTime: Double?
    public var endTime: Double?
    
    public var uploadFlow: Int = 0
    public var downloadFlow: Int = 0
    
    public var fileFolder = ""
    public var fileName = ""
    
    public var state: Int = 1
    public var note: String?
    public var ignore: Bool = false
    
    
}

public class SessionTable: DatabaseTable {
    let table = Table("session")
    let id = Expression<Int64>("id")
    let taskId = Expression<Int64?>("task_id")
    let remoteAddress = Expression<String?>("remote_address")
    let localAddress = Expression<String?>("local_address")
    let host = Expression<String?>("host")
    let schemes = Expression<String?>("schemes")
    let requestLine = Expression<String?>("request_line")
    let methods = Expression<String?>("methods")
    let uri = Expression<String?>("uri")
    let suffix = Expression<String?>("suffix")
    let requestContentType = Expression<String?>("request_content_type")
    let requestContentEncoding = Expression<String?>("request_content_encoding")
    let requestHeader = Expression<String?>("request_header")
    let requestHttpVersion = Expression<String?>("request_http_version")
    let requestBody = Expression<String?>("request_body")
    let target = Expression<String?>("target")
    let httpCode = Expression<String?>("http_code")
    let responseContentType = Expression<String?>("response_content_type")
    let responseContentEncoding = Expression<String?>("response_content_encoding")
    let responseHeader = Expression<String?>("response_header")
    let responseHttpVersion = Expression<String?>("response_http_version")
    let responseBody = Expression<String?>("response_body")
    let responseMsg = Expression<String?>("response_msg")
    let startTime = Expression<Double?>("start_time")
    let connectTime = Expression<Double?>("connect_time")
    let connectedTime = Expression<Double?>("connected_time")
    let handshakeTime = Expression<Double?>("handshake_time")
    let requestEndTime = Expression<Double?>("request_end_time")
    let responseStartTime = Expression<Double?>("response_start_time")
    let responseEndTime = Expression<Double?>("response_end_time")
    let endTime = Expression<Double?>("end_time")
    let uploadFlow = Expression<Int>("upload_flow")
    let downloadFlow = Expression<Int>("download_flow")
    let fileFolder = Expression<String>("file_folder")
    let fileName = Expression<String>("file_name")
    let state = Expression<Int>("state")
    let note = Expression<String?>("note")
    let ignore = Expression<Bool>("ignore")
    
    init() {
        try? createTable()
    }
    
    func createTable() throws {
        try DatabaseManager.shared?.connection().run(table.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(taskId)
            t.column(remoteAddress)
            t.column(localAddress)
            t.column(host)
            t.column(schemes)
            t.column(requestLine)
            t.column(methods)
            t.column(uri)
            t.column(suffix)
            t.column(requestContentType)
            t.column(requestContentEncoding)
            t.column(requestHeader)
            t.column(requestHttpVersion)
            t.column(requestBody)
            t.column(target)
            t.column(httpCode)
            t.column(responseContentType)
            t.column(responseContentEncoding)
            t.column(responseHeader)
            t.column(responseHttpVersion)
            t.column(responseBody)
            t.column(responseMsg)
            t.column(startTime)
            t.column(connectTime)
            t.column(connectedTime)
            t.column(handshakeTime)
            t.column(requestEndTime)
            t.column(responseStartTime)
            t.column(responseEndTime)
            t.column(endTime)
            t.column(uploadFlow)
            t.column(downloadFlow)
            t.column(fileFolder)
            t.column(fileName)
            t.column(state)
            t.column(note)
            t.column(ignore)
        })
    }
    
    public func insert(model: Session) throws {
        let insert = table.insert(taskId <- model.taskId, remoteAddress <- model.remoteAddress, localAddress <- model.localAddress, host <- model.host, schemes <- model.schemes, requestLine <- model.requestLine, methods <- model.methods, uri <- model.uri, suffix <- model.suffix, requestContentType <- model.requestContentType, requestContentEncoding <- model.requestContentEncoding, requestHeader <- model.requestHeader, requestHttpVersion <- model.requestHttpVersion, requestBody <- model.requestBody, target <- model.target, httpCode <- model.httpCode, responseContentType <- model.responseContentType, responseContentEncoding <- model.responseContentEncoding, responseHeader <- model.responseHeader, responseHttpVersion <- model.responseHttpVersion, responseBody <- model.responseBody, responseMsg <- model.responseMsg, startTime <- model.startTime, connectTime <- model.connectTime, connectedTime <- model.connectedTime, handshakeTime <- model.handshakeTime, requestEndTime <- model.requestEndTime, responseStartTime <- model.responseStartTime, responseEndTime <- model.responseEndTime, endTime <- model.endTime, uploadFlow <- model.uploadFlow, downloadFlow <- model.downloadFlow, fileFolder <- model.fileFolder, fileName <- model.fileName, state <- model.state, note <- model.note, ignore <- model.ignore)
        try DatabaseManager.shared?.connection().run(insert)
    }
    
    func fetchAll() throws -> [Session] {
        return []
    }
    
    public func update(model: Session) throws {
        try DatabaseManager.shared?.connection().run(table.filter(self.id == model.id).update(taskId <- model.taskId, remoteAddress <- model.remoteAddress, localAddress <- model.localAddress, host <- model.host, schemes <- model.schemes, requestLine <- model.requestLine, methods <- model.methods, uri <- model.uri, suffix <- model.suffix, requestContentType <- model.requestContentType, requestContentEncoding <- model.requestContentEncoding, requestHeader <- model.requestHeader, requestHttpVersion <- model.requestHttpVersion, requestBody <- model.requestBody, target <- model.target, httpCode <- model.httpCode, responseContentType <- model.responseContentType, responseContentEncoding <- model.responseContentEncoding, responseHeader <- model.responseHeader, responseHttpVersion <- model.responseHttpVersion, responseBody <- model.responseBody, responseMsg <- model.responseMsg, startTime <- model.startTime, connectTime <- model.connectTime, connectedTime <- model.connectedTime, handshakeTime <- model.handshakeTime, requestEndTime <- model.requestEndTime, responseStartTime <- model.responseStartTime, responseEndTime <- model.responseEndTime, endTime <- model.endTime, uploadFlow <- model.uploadFlow, downloadFlow <- model.downloadFlow, fileFolder <- model.fileFolder, fileName <- model.fileName, state <- model.state, note <- model.note, ignore <- model.ignore))
    }
    
    public func delete(model: Session) throws {
        try DatabaseManager.shared?.connection().run(table.filter(self.id == model.id).delete())
    }
    
    typealias ModelType = Session
}
