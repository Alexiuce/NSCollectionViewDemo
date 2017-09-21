//
//  XCPullRefreshScrollView.swift
//  iFeiBo
//
//  Created by alexiuce  on 2017/9/20.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa



class XCPullRefreshScrollView: NSScrollView {

    fileprivate var headerView : NSView?                // 头部视图
    fileprivate weak var xc_target : AnyObject?            //
    fileprivate var xc_action : Selector?                  //
    fileprivate var headerHeight : CGFloat = 44         //
    fileprivate var isRefreshing = false                //
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }

 
    override func scrollWheel(with event: NSEvent) {
        if isRefreshing{return}
        if event.phase == .ended {
            if showHeaderView() {
                startRefreshing()
                return
            }
        }
        super.scrollWheel(with: event)
    }
}


// MARK: setup UI
extension XCPullRefreshScrollView{
    fileprivate func setupHeader(){
        if headerView != nil{return}
        
        let rect = contentView.frame
        headerView = NSView(frame: NSMakeRect(0, -headerHeight, NSWidth(rect), headerHeight))
        headerView?.wantsLayer = true
        contentView.addSubview(headerView!)
        headerView?.layer?.backgroundColor = NSColor.red.cgColor
        headerView?.autoresizingMask = [.viewWidthSizable]
        
    }
}


extension XCPullRefreshScrollView{
    fileprivate func showHeaderView() -> Bool{
        guard headerView != nil else { return false }
        let scrollY = contentView.bounds.origin.y
        let minScrollY = -headerHeight
        return scrollY <= minScrollY
    }
    
    fileprivate func startRefreshing(){
        XCPring("START REFRESH")
        isRefreshing = true
        documentView?.frame.origin.y = headerHeight
        headerView?.frame.origin.y = 0
        contentView.scroll(to: NSZeroPoint)
        guard let target = xc_target else { return  }
        guard let action = xc_action else { return  }
        _ = target.perform(action)
    }
    
    func stopHeaderRefresh()  {
        isRefreshing = false
        
        headerView?.frame.origin.y = -headerHeight
        documentView?.frame.origin.y = 0
        

    }
    
    func xc_headerRefreshTarget(_ target: AnyObject? ,action : Selector) {
        xc_action = action
        xc_target = target
        setupHeader()
    }
    
}

