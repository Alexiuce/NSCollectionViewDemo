//
//  HomeCellView.swift
//  iFeiBo
//
//  Created by alexiuce  on 2017/9/19.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa

class HomeCellView: NSTableCellView {

    @IBOutlet weak var headImageView: NSImageView!  // 头像
    
    @IBOutlet weak var textLabel: NSTextField!      // 微博正文
    
    @IBOutlet weak var nameLabel: NSTextField!      // 名称

    @IBOutlet weak var timeLabel: NSTextField!      // 实际
    
    @IBOutlet weak var sourceLabel: NSTextField!    // 来源
    @IBOutlet weak var vipImageView: NSImageView!   // vip
    
    @IBOutlet weak var rankImageView: NSImageView!  // 认证
  
    
    @IBOutlet weak var picWidthCons: NSLayoutConstraint!            // 配图宽度约束
    @IBOutlet weak var picHeightCons: NSLayoutConstraint!           // 配图高度约束
    
    
    var status : WBStatus? {
        didSet{
            guard let status = status else { return  }
            timeLabel.stringValue = status.createdString
            nameLabel.stringValue = status.user?.name ?? ""
            textLabel.stringValue = status.text 
            guard let url = status.user?.avatar_hd else { return  }
            headImageView.kf.setImage(with: URL(string: url))
            sourceLabel.stringValue = status.sourceText
            rankImageView.image = NSImage(named: "common_icon_membership_level\( status.user!.mbrank)")
            switch status.user!.verified_type {
            case 0:
                vipImageView.image = NSImage(named: "avatar_vip")
            case 2,3,5:
                vipImageView.image = NSImage(named: "avatar_enterprise_vip")
            case 220:
                vipImageView.image = NSImage(named: "avatar_grassroot")
            default:
                vipImageView.image = nil
            }
            
            guard let pics = status.pic_urls else {
                picHeightCons.constant = 0
                picWidthCons.constant = 0
                return
            }
            let margin : CGFloat = 10
            var wh : CGSize = NSZeroSize
            var imgWH : CGFloat = 0
            switch pics.count {
            case 0 :
                wh = NSZeroSize
                imgWH = 0
            case 1 :
                wh = NSMakeSize(80, 80)
                imgWH = 80 - 1
            case 4:
                wh = NSMakeSize(170, 170)  //80 * 2 + margin
                imgWH = 80 - 1
            default:
                let w = bounds.width - 2 * margin               // 宽度
                let col : CGFloat = pics.count == 2 ? 1 : 2     // 列数
                imgWH = (w - col * margin) / (col + 1)   - 1   // item宽度
                let row = CGFloat((pics.count - 1) / 3 + 1)     // 行数
                let h = row * imgWH + (row - 1) * margin        // 高度
                wh = NSMakeSize(w, h)
            }
            
            XCPring("change bounds \(NSStringFromRect(bounds))")
            
            picWidthCons.constant = wh.width
            picHeightCons.constant = wh.height
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







