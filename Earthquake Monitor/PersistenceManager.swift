//
//  PersistenceManager.swift
//  Earthquake Monitor
//
//  Created by JJLZ on 3/16/16.
//  Copyright © 2016 ESoft. All rights reserved.
//

import Foundation

class PersistenceManager {
    
    class func saveNSArray(arrayToSave: NSArray, path: String) {
        NSKeyedArchiver.archiveRootObject(arrayToSave, toFile: path)
    }
    
    class func loadNSArray(path: String) -> NSArray? {
        let result = NSKeyedUnarchiver.unarchiveObjectWithFile(path)
        return result as? NSArray
    }
}