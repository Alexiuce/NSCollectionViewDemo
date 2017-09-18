//
//  UserAccount.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/17.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa
import MJExtension

class UserAccount: NSObject,NSCoding {
    var access_token = ""
    var expires_in = ""
    var remind_in = ""
    var uid = ""
    
    init(dict : [String : Any]?){
        super.init()
        guard let dict = dict else { return }
        mj_setKeyValues(dict)
    }

    
    
    /** 解码对象（反序列化）*/
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as! String
        expires_in = aDecoder.decodeObject(forKey: "expires_in") as! String

        remind_in = aDecoder.decodeObject(forKey: "remind_in") as! String
    
        uid = aDecoder.decodeObject(forKey: "uid") as! String
        
    }
    /** 编码对象（序列化）*/
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_in, forKey: "expires_in")
        aCoder.encode(remind_in, forKey:  "remind_in")
        aCoder.encode(uid, forKey: "uid")
    }
    
    override var description: String{
        let keys = ["uid","expires_in","access_token"]
        return dictionaryWithValues(forKeys: keys).description
    }
}


