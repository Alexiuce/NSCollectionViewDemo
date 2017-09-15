//
//  ViewController.swift
//  CollectionDemo
//
//  Created by Alexcai on 2016/12/20.
//  Copyright © 2016年 Alexcai. All rights reserved.
//

import Cocoa

// 设置重用标识
fileprivate  let reusedKey = "demoItem"

class ViewController: NSViewController {

    // 连线属性
    @IBOutlet weak var collectionView: NSCollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置collectionView
        setCollectionView()
    }
}
// MARK: - 设置collectionView
extension ViewController{
    fileprivate func setCollectionView(){
        // 注册item
        collectionView.register(CustomItem.self, forItemWithIdentifier: reusedKey)
        // 设置数据源
        collectionView.dataSource = self
        // 获取布局
        let layout = collectionView.collectionViewLayout as! NSCollectionViewFlowLayout
        // 设置item尺寸
        layout.itemSize = NSSize(width: 100, height: 100)
        
    }
}
// MARK: - NSCollectionViewDataSource 数据源方法
extension ViewController: NSCollectionViewDataSource{
    // item数量
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    // 返回重用的item(如果没有系统会自动创建注册时指定的item类型),参考第28行代码
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        return collectionView.makeItem(withIdentifier: reusedKey, for: indexPath)
    }
}
