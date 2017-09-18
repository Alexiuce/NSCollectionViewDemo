//
//  UAToolManager.swift
//  iFeiBo
//
//  Created by alexiuce  on 2017/9/18.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

class UAToolManager: NSObject {
    
    static let defaultManager = UAToolManager()
    lazy var userAccount : UserAccount? = {
        guard let account = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath) as? UserAccount else { return nil}

        return account
    }()
    
    fileprivate let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! + "/userAccount.dat"
    
    func saveUserAccount(_ account : UserAccount) -> Bool {
        
       return NSKeyedArchiver.archiveRootObject(account, toFile: filePath)
    }
    
}
