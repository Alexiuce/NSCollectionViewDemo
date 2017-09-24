//
//  PicsView.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/24.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

class PicsView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        NSColor.orange.set()
        NSRectFill(dirtyRect)
        // Drawing code here.
    }
    
}
