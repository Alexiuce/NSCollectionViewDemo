//
//  PicsView.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/24.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa
import Kingfisher

let kPicuterWH : CGFloat = 100      // 图片宽高
let kMargin : CGFloat = 10          // 间距


class PicsView: NSView {

    var picUrls : [URL] = []  {
        didSet{
            if oldValue.count != 0 {subviews.removeAll()}               // 清除旧视图
            let imgCount  = picUrls.count
            var itemInRow  = 3
            switch imgCount {
            case 0:
                caculateSize = NSZeroSize
            case 1:
                caculateSize = NSMakeSize(kPicuterWH, kPicuterWH)
            case 2:
                caculateSize = NSMakeSize(kPicuterWH * 2 + kMargin, kPicuterWH)
            case 4:
                caculateSize = NSMakeSize(kPicuterWH * 2 + kMargin, kPicuterWH * 2 + kMargin)
                itemInRow = 2
            default:
                // 计算行数
                let row = CGFloat((imgCount - 1) / 3 + 1)
                caculateSize = NSMakeSize(kPicuterWH * 3 + kMargin * 2, kPicuterWH * row + (row - 1) * kMargin)                
            }
            
        
            for i in 0..<imgCount {
                let imageView = NSImageView(frame: NSMakeRect(0, 0, kPicuterWH, kPicuterWH))
                imageView.imageAlignment = .alignCenter
                imageView.imageScaling = .scaleNone
                imageView.animates = true
                
                let pointX = CGFloat(i % itemInRow) * (kPicuterWH + kMargin)
                let pointY = CGFloat(i / itemInRow) * (kPicuterWH + kMargin)
                imageView.setFrameOrigin(NSMakePoint(pointX, pointY))
                addSubview(imageView)
               
                imageView.kf.setImage(with: picUrls[i])
                let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(handleImageViewClick(_:)))
                imageView.addGestureRecognizer(clickGesture)
            }
        }
    }
    
    var caculateSize = NSZeroSize
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        NSColor.orange.set()
        NSRectFill(dirtyRect)
        // Drawing code here.
    }
    
}

// MARK: - custom methon

extension PicsView{
    func handleImageViewClick(_ gesture : NSGestureRecognizer)  {
        
        
        XCPring("click image view \(gesture.view!)")
    }
}
