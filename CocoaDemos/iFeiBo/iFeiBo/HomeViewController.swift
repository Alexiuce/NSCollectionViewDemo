//
//  HomeViewController.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/16.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa
import Alamofire


let reusedKey = "homeCell"

class HomeViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!         // NSTableView
    
    var statuses : [WBStatus] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        let nib = NSNib(nibNamed: "HomeStatusView", bundle: nil)!
//        tableView.register(nib, forIdentifier: reusedKey)
    
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTableViewResize), name: .NSViewFrameDidChange, object: tableView)
        
        HTTPManager.getWBStatus { (dict) in
            self.statuses = WBStatus.statusesFromDicts(dict?["statuses"] as! [[String : Any]])
            self.tableView.reloadData()
        }
    }
    
    func handleTableViewResize(){
      
        let vr = tableView.visibleRect
        let range = tableView.rows(in: vr)
       
        if range.length > 0 {
            let indexes = IndexSet(integersIn: range.location..<range.location + range.length - 1)
            
            tableView.noteHeightOfRows(withIndexesChanged: indexes)
            XCPring(indexes)
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
        let cell = tableView.make(withIdentifier: reusedKey, owner: self) as! HomeCellView
        
        cell.status = statuses[row]
        return cell

    }
    
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let cell = tableView.make(withIdentifier: reusedKey, owner: self) as! HomeCellView
        
        cell.status = statuses[row]
        
        cell.frame.size.width = tableView.bounds.size.width
        
        cell.needsLayout = true
        cell.layoutSubtreeIfNeeded()
        
        XCPring(NSStringFromRect(cell.frame))
        XCPring(NSStringFromRect(tableView.frame))
        return cell.fittingSize.height
        
    }
    
}
