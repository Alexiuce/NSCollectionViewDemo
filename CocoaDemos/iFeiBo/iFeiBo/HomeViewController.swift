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
    
    var currentSelectView : HomeCellView?
    override func viewDidLoad() {
        super.viewDidLoad()


    
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTableViewResize), name: .NSViewFrameDidChange, object: tableView)
        
        HTTPManager.getWBStatus { (dict) in
            self.statuses = WBStatus.statusesFromDicts(dict?["statuses"] as! [[String : Any]])
            self.tableView.reloadData()
        }
    }
    
    func handleTableViewResize(){
      
            let indexes = IndexSet(integersIn: 0..<tableView.numberOfRows)
            NSAnimationContext.beginGrouping()
            NSAnimationContext.current().duration = 0
            tableView.noteHeightOfRows(withIndexesChanged: indexes)
            NSAnimationContext.endGrouping()
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
        
        return cell.fittingSize.height
        
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard let selectView = tableView.view(atColumn: 0, row: tableView.selectedRow, makeIfNecessary: false) as? HomeCellView else {return}
        if let currentSelectView = currentSelectView {
            currentSelectView.backgroundStyle = .light
        }
        selectView.backgroundStyle = .dark
        currentSelectView = selectView
        
    }
    
}
