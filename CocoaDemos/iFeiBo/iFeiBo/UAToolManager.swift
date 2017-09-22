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
    
    fileprivate let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! + "/userAccount.dat"
    lazy var userAccount : UserAccount? = {
        guard let account = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath) as? UserAccount else { return nil}

        return account
    }()
    
    
    func saveUserAccount(_ account : UserAccount) -> Bool {
        
       return NSKeyedArchiver.archiveRootObject(account, toFile: filePath)
    }
    
}
