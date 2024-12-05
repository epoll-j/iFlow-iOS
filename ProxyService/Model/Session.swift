//
//  Session.swift
//  iFlow
//
//  Created by dubhe on 2023/10/8.
//

import Foundation
import NIOCore
import NIOHTTP1
import SwiftyJSON

public enum FileType {
    case Request
    case Response
}

public class Session: Codable {
    public var id: String = UUID().uuidString
    public var taskId: String?
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
    
    private var _ignore = false
    public var ignore: Bool {
        set(newVal) {
            _ignore = newVal
            if (!newVal) {
                self._addSessionCount()
            }
        }
        
        get {
            return _ignore
        }
    }
    
    
    init() {
        
    }
    
    public static func newSession(_ task: Task) -> Session {
        let session = Session()
        session.taskId = task.id
        session.startTime = Date().timeIntervalSince1970
        session.fileFolder = task.fileFolder
        return session
    }
    
    private func _addSessionCount() {
//        DispatchQueue.main.async {
//            let realm = RealmManager.shared
//            let task = realm.object(ofType: TaskModel.self, forPrimaryKey: self.taskId)
//            try? realm.write {
//                task?.sessionsCount += 1
//            }
//        }
    }
    
    public func save() {
        if self.ignore {
            return
        }
//        DispatchQueue.main.async {
//            let realm = RealmManager.shared
//            if let jsonData = try? JSONEncoder().encode(self) {
//                if let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []),
//                   let dictionary = jsonObject as? [String: Any] {
//                    try? realm.write({
//                        realm.add(SessionModel(value: dictionary), update: .modified)
//                    })
//                }
//            }
//            
//        }
    }
    
    public func writeBody(type: FileType, buffer: ByteBuffer?, realName: String = "") {
        if self.ignore {
            return
        }
        
        if requestBody == nil, type == .Request {
            requestBody = "req_\(taskId!)_\(id)\(realName)"
        }
        if responseBody == nil, type == .Response {
            responseBody = "rsp_\(taskId!)_\(id)\(realName)"
        }
        guard let body = buffer else {
            return
        }
        
        var filePath = type == .Request ? requestBody : responseBody
        filePath = "\(ProxyService.getStoreFolder())\(fileFolder)/\(filePath!)"
        let fileManager = FileManager.default
        let exist = fileManager.fileExists(atPath: filePath!)
        if !exist {
            fileManager.createFile(atPath: filePath!, contents: nil, attributes: nil)
        }
        
        guard let data = body.getData(at: body.readerIndex, length: body.readableBytes) else {
            print("no data !")
            return
        }
        
        let fileHandle = FileHandle(forWritingAtPath: filePath!)
        if exist {
            fileHandle?.seekToEndOfFile()
        }
        fileHandle?.write(data)
        fileHandle?.closeFile()
    }
    
    static func getIPAddress(socketAddress: SocketAddress?) -> String {
        if let address = socketAddress?.description {
            let array = address.components(separatedBy: "/")
            return array.last ?? address
        } else {
            return "unknow"
        }
    }
    
    static func getUserAgent(target: String?) -> String {
        if target != nil {
            let firstTarget = target!.components(separatedBy: " ").first
            return firstTarget?.components(separatedBy: "/").first ?? target!
        }
        return ""
    }
    
    static func getHeadsJson(headers: HTTPHeaders) -> String {
        var reqHeads = [String: String]()
        for kv in headers {
            reqHeads[kv.name] = kv.value
        }
        return reqHeads.toJson()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


//public class SessionModel: Object, ObjectKeyIdentifiable {
//    @Persisted(primaryKey: true) public var id: String
//    @Persisted public var taskId: String!
//    @Persisted public var remoteAddress: String?
//    @Persisted public var localAddress: String?
//    @Persisted public var host: String?
//    @Persisted public var schemes: String?
//    @Persisted public var requestLine: String?
//    @Persisted public var methods: String?
//    @Persisted public var uri: String?
//    @Persisted public var suffix: String?
//    
//    @Persisted public var requestContentType: String?
//    @Persisted public var requestContentEncoding: String?
//    @Persisted public var requestHeader: String?
//    @Persisted public var requestHttpVersion: String?
//    @Persisted public var requestBody: String?
//    
//    @Persisted public var target: String?
//    @Persisted public var httpCode: String?
//    
//    @Persisted public var responseContentType: String?
//    @Persisted public var responseContentEncoding: String?
//    @Persisted public var responseHeader: String?
//    @Persisted public var responseHttpVersion: String?
//    @Persisted public var responseBody: String?
//    @Persisted public var responseMsg: String?
//    
//    @Persisted public var startTime: Double?
//    @Persisted public var connectTime: Double?
//    @Persisted public var connectedTime: Double?
//    @Persisted public var handshakeTime: Double?
//    @Persisted public var requestEndTime: Double?
//    @Persisted public var responseStartTime: Double?
//    @Persisted public var responseEndTime: Double?
//    @Persisted public var endTime: Double?
//    
//    @Persisted public var uploadFlow: Int = 0
//    @Persisted public var downloadFlow: Int = 0
//    
//    @Persisted public var fileFolder = ""
//    @Persisted public var fileName = ""
//    
//    @Persisted public var state: Int = 1
//    @Persisted public var note: String?
//    
//    public override init() {
//        
//    }
//}
//
