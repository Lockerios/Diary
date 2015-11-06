//
//  FileManager.swift
//  TextImageDemo
//
//  Created by yangyang on 15/11/6.
//  Copyright © 2015年 LLZ. All rights reserved.
//

import Foundation

private let sharedInstance = FileManager()

class FileManager {
    
    var filePath: String
    
    //MARK: - Lifecycle
    
    class var sharedFileManager: FileManager {
        return sharedInstance
    }
    
    init() {
        self.filePath = ""
        self.p_createFolder()
    }
    
    //MARK: - Methods
    
    func p_createFolder() {
        let paths = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true)
        let libDirectory = paths[0]
        let documentsDirectory = libDirectory+"/Caches/"
        let dataPath = documentsDirectory+"MyNetworkCache"
        
        filePath = dataPath
        
        if !NSFileManager.defaultManager().fileExistsAtPath(dataPath) {
            do {
              try NSFileManager.defaultManager().createDirectoryAtPath(dataPath, withIntermediateDirectories: false, attributes: nil)
            } catch is NSError {
                print("createDirectoryAtPath failed at \(dataPath)")
            }
        } else {
            print("fileExistsAtPath \(dataPath)")
        }
    }
    
    func p_saveCache(obj: AnyObject,cacheFileName: String) {
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(obj, options: .PrettyPrinted)

            p_write(jsonData, saveFileName: cacheFileName, filePath: filePath)
            
            print("saved success")
        } catch is NSError {
            print("json transform error")
        }
    }
    
    func p_readCache(fileName: String) -> (AnyObject) {
        let data = p_read(fileName, filePath: filePath)
        do {
            let jsonObj = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            
            return jsonObj
        } catch is NSError {
            print("read json error")
            
            return ""
        }
    }
    
    func p_read(saveFileName: String, filePath: String) -> (NSData) {
        let fileName = saveFileName+".txt"
        let backSlash = filePath+"/"
        let fileAtPath = backSlash+fileName
        
        let data = NSData.init(contentsOfURL: NSURL.init(fileURLWithPath: fileAtPath))
        
        return data!
    }
    
    func p_write(data: NSData, saveFileName: String, filePath: String) {
        let fileName = saveFileName+".txt"
        let backSlash = filePath+"/"
        let fileAtPath = backSlash+fileName
        
        if !NSFileManager.defaultManager().fileExistsAtPath(fileAtPath) {
            NSFileManager.defaultManager().createFileAtPath(fileAtPath, contents: nil, attributes: nil)
        }
        
        data.writeToFile(fileAtPath, atomically: false)
    }
}