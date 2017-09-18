//
//  HTTPManager.swift
//  iFeiBo
//
//  Created by alexiuce  on 2017/9/18.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa
import Alamofire

class HTTPManager {

   class func getWBStatus(_ finished : ([String : AnyObject]?)->()) {
        
        // 1. url
        let statusURL = URL(string: WBStatusURL)!
        // 2. send https request
        Alamofire.request(statusURL, method: HTTPMethod.get, parameters: ["access_token": UAToolManager.defaultManager.userAccount!.access_token]).responseJSON { (response) in
            
        }
        
    }

}
