//
//  HomeViewController.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/16.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa
import Alamofire

class HomeViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!         // NSTableView
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        HTTPManager.getWBStatus { (dict) in
            
        }
        
    }
    
    
}

// MARK: - NSTableViewDataSource
extension HomeViewController : NSTableViewDataSource{
    
}
// MARK: -  NSTableViewDelegate
extension HomeViewController : NSTableViewDelegate{
    
}
