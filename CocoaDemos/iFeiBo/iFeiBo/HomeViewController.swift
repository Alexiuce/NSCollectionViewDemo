//
//  HomeViewController.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/16.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa
import Alamofire


let reusedKey = "HomeCellReusedKey"

class HomeViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!         // NSTableView
    
    var statuses : [WBStatus] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let nib = NSNib(nibNamed: "HomeStatusView", bundle: nil)!
        tableView.register(nib, forIdentifier: reusedKey)
    
        
        
        HTTPManager.getWBStatus { (dict) in
            self.statuses = WBStatus.statusesFromDicts(dict?["statuses"] as! [[String : Any]])
            self.tableView.reloadData()
        }
        
    }
}

// MARK: - NSTableViewDataSource
extension HomeViewController : NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return statuses.count
    }
    
}
// MARK: -  NSTableViewDelegate
extension HomeViewController : NSTableViewDelegate{
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: reusedKey, owner: self) as! HomeStatusView
        
        cell.status = statuses[row]
        
        return cell
        
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let cell = tableView.make(withIdentifier: reusedKey, owner: self) as! HomeStatusView
        cell.status = statuses[row]
        cell.layoutSubtreeIfNeeded()
        print(cell.frame.width)
        return cell.frame.height
        
    }
    
    
    
    
    
}
