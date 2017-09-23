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

    var created_at = ""{    // 微博创建时间
        didSet{
            createdString = created_at.convertWBTime()
        }
    }
    var text = ""               // 微博正文
    var id : Int64 = 0          // 微博id
    var source = "" { // 微博来源
        didSet{
           sourceText = source.getTagAHtmlText()
        }
    }
    var user : WBStatusUser?        // 微博用户
    
    var pic_urls : [[String : String]]?   // 配图数组
    
    var sourceText = ""
    var createdString = ""
    
    
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
