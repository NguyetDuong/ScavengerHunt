//
//  ItemsManager.swift
//  ScavengerHunt
//
//  Created by Nguyet Duong on 8/8/15.
//  Copyright (c) 2015 Nguyet Duong. All rights reserved.
//

import Foundation

class ItemsManager {
    var items = [ScavengerHuntItem]()
    
    // lazy == not going to be created until it's needed
    lazy private var archivePath: String = {
        let fileManager = NSFileManager.defaultManager()
        let documentsDiectoryURLS = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask) as! [NSURL]
        let archiveURL = documentsDiectoryURLS.first!.URLByAppendingPathComponent("ScavengerHuntItem", isDirectory: false)
        return archiveURL.path!
    }()
    
    init() {
        unarchiveSaveItems()
    }
    
    func save() {
        NSKeyedArchiver.archiveRootObject(items, toFile: archivePath)
    }
    
    private func unarchiveSaveItems() {
        if NSFileManager.defaultManager().fileExistsAtPath(archivePath) {
            let savedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(archivePath) as! [ScavengerHuntItem]
            items = savedItems
        }
    }
    
}