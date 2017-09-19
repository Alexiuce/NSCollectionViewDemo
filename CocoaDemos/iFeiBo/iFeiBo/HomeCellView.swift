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
    
    override var backgroundStyle: NSBackgroundStyle{
        didSet{
            if backgroundStyle == .dark {
                layer?.backgroundColor = NSColor.red.cgColor
            }else{
                layer?.backgroundColor = NSColor.clear.cgColor
            }
    
        }
   
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wantsLayer = true
    }
    
}
