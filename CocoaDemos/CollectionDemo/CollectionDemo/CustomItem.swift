//
//  CustomItem.swift
//  CollectionDemo
//
//  Created by Alexcai on 2016/12/20.
//  Copyright © 2016年 Alexcai. All rights reserved.
//

import Cocoa

class CustomItem: NSCollectionViewItem {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    override func viewDidAppear() {
        super.viewDidAppear()
        view.layer?.backgroundColor = NSColor.lightGray.cgColor
    }
    
}
