//
//  UserAccount.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/17.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

class UserAccount: NSObject {
    var access_token = ""
    var expires_in = 0
    var isRealName = false
    var remind_in = 0
    var scope = ""
    var uid = 0
    
    init(dict : NSDictionary){
        super.init()
        self.setValuesForKeys(dict as! [String : Any])
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    

}
