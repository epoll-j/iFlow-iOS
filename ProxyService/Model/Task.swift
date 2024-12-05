//
//  Task.swift
//  iFlow
//
//  Created by Dubhe on 2023/8/13.
//

import Foundation
import SwiftyJSON

public class Task {
    public var id: String = UUID().uuidString
    public var localEnable: Int = 1
    public var wifiEnable: Int = 1
    public var fileFolder: String!
    public var startTime: Double = 1
    public var stopTime: Double = 1
    public var sessions: Set<String> = Set()
    
    public var rule: TaskRule!
    
    var wifiIP: String = "127.0.0.1"
    var port: Int = 9527
    
    public init() {
        fileFolder = "task-\(self.id)"
        self.rule = TaskRule()
    }
    
    
    func getFullPath() -> String {
        var filePath = ProxyService.getStoreFolder()
        filePath.append(fileFolder)
        return filePath
    }
    
    func createFileFolder() {
        let filePath = getFullPath()
        let fileManager = FileManager.default
        var isDir : ObjCBool = false
        let isExits = fileManager.fileExists(atPath: filePath, isDirectory: &isDir)
        if isExits, isDir.boolValue {
            let errorStr = "Delete \(String(describing: fileFolder))，Because it's not a folder !"
            NSLog(errorStr)
            try? fileManager.removeItem(atPath: filePath)
            try? fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
        }
        if !isExits {
            try? fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    public func updateTime() {
//        DispatchQueue.main.async {
//            let realm = RealmManager.shared
//            let task = realm.object(ofType: TaskModel.self, forPrimaryKey: self.id)
//            try? realm.write {
//                task?.stopTime = Date().timeIntervalSince1970
//            }
//        }
    }
    
    public func save() {
//        DispatchQueue.main.async {
//            let realm = RealmManager.shared
//            try? realm.write {
//                realm.add(TaskModel(id: self.id, fileFolder: self.fileFolder, startTime: self.startTime, stopTime: self.stopTime, sessionsCount: self.sessions.count), update: .modified)
//            }
//        }
    }
}

//public class TaskModel: Object, ObjectKeyIdentifiable {
//    @Persisted(primaryKey: true) public var id: String
//    @Persisted public var fileFolder = ""
//    @Persisted public var startTime: Double = 1
//    @Persisted public var stopTime: Double = 1
//    @Persisted public var sessionsCount: Int = 0
//    
//    init(id: String, fileFolder: String = "", startTime: Double, stopTime: Double, sessionsCount: Int) {
//        super.init()
//        self.id = id
//        self.fileFolder = fileFolder
//        self.startTime = startTime
//        self.stopTime = stopTime
//        self.sessionsCount = sessionsCount
//    }
//    
//    public override init() {
//        
//    }
//    
//    public func removeAllSessions() {
//        DispatchQueue.main.async {
//            let realm = RealmManager.shared
//            let del = realm.objects(SessionModel.self).filter { model in
//                return model.taskId == self.id
//            }
//            try? realm.write({
//                realm.delete(del)
//            })
//        }
//    }
//}
