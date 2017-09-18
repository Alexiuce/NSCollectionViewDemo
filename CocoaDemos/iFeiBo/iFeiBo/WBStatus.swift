//
//  WBStatus.swift
//  iFeiBo
//
//  Created by alexiuce  on 2017/9/18.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa
import MJExtension

class WBStatus: NSObject {

    var created_at = ""
    var text = ""
    var id : Int64 = 0
    var user : WBStatusUser?
    
    override init() {
        super.init()
    }
    
    init(_ dict : [String : Any]){
        super.init()
        mj_setKeyValues(dict)
    }
    
    class func statusesFromDicts(_ dicts : [[String : Any]]) -> [WBStatus] {
        return mj_objectArray(withKeyValuesArray: dicts) as! [WBStatus]
    }
    
}
