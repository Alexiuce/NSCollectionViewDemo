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
  
    @IBOutlet weak var pictureView: PicsView!
    
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
            pictureView.picUrls = status.picURL
            picWidthCons.constant = pictureView.caculateSize.width
            picHeightCons.constant = pictureView.caculateSize.height
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







