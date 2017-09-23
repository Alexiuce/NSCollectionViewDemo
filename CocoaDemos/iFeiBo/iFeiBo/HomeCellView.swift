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
    @IBOutlet weak var imgCollectionView: NSCollectionView!         // 配图collectionView
    
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
            
            guard let pics = status.pic_urls else { return  }
            
            let picSize = caculatePicCollectionSize(pics.count)
        
            picWidthCons.constant = picSize.width
            picHeightCons.constant = picSize.height
            let margin : CGFloat = 10
            let imgWH = (bounds.width - 4 * margin ) / 3
            let flowLayout = imgCollectionView.collectionViewLayout as! NSCollectionViewFlowLayout
            if pics.count == 1 {
                flowLayout.itemSize = NSMakeSize(80, 80)
            }else{
                flowLayout.itemSize = NSMakeSize(imgWH, imgWH)
            }
            
            XCPring("pic count = \(pics.count),pic size = \(picSize)")
            
            
            
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
        imgCollectionView.register(PictureColletionItem.self, forItemWithIdentifier: "pictures")
        imgCollectionView.dataSource = self
        imgCollectionView.delegate = self
  
      
        
    }
}

extension HomeCellView : NSCollectionViewDataSource{
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return status?.pic_urls?.count ?? 0
    }
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let item = collectionView.makeItem(withIdentifier: "pictures", for: indexPath) as! PictureColletionItem
        return item
        
    }
    
}
extension HomeCellView : NSCollectionViewDelegate{
    
}


extension HomeCellView{
    fileprivate func caculatePicCollectionSize(_ pics :Int ) -> NSSize{
        if pics == 0 {return NSZeroSize}
    
        if pics == 1 {return NSMakeSize(80, 80)}
        let margin : CGFloat = 10   // 间距
        let imgWH = (bounds.width - 4 * margin ) / 3
        if pics == 4 {
            let pWidth = imgWH * 2 + 10
            return NSMakeSize(pWidth, pWidth)
        }
        
        
        let rows =  CGFloat((pics - 1) / 3 + 1)
        let width = bounds.width - 20
        let height = rows * imgWH + (rows - 1) * 10
        return NSMakeSize(width, height)
    }
}


