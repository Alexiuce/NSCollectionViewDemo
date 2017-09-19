//
//  HomeCellView.swift
//  iFeiBo
//
//  Created by alexiuce  on 2017/9/19.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

class HomeCellView: NSTableCellView {

    @IBOutlet weak var headImageView: NSImageView!
    
    @IBOutlet weak var textLabel: NSTextField!
    

    
    var status : WBStatus? {
        didSet{
        
            guard let url = status?.user?.avatar_hd else { return  }
            headImageView.kf.setImage(with: URL(string: url))
            textLabel.stringValue = status?.text ?? ""
        }
    }
    
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
