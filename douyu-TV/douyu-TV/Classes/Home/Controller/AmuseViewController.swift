//
//  AmuseViewController.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/13.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit
/// 定义标识符
private let kRecomendCell = "kRecomendCell"
private let kAmuseHeaderView = "kAmuseHeaderView"


/// 定义常量值
private let kMargin : CGFloat = 5
private let kItemWidth = (kScreenWidth - 3 * kMargin) / 2
private let kItemHeight = (kItemWidth * 3) / 4
private let kPrettyCellH = kItemWidth * 4 / 3
private let kHeaderHeight : CGFloat = 50
private let kTopHeaderH : CGFloat = kScreenWidth * 3 / 8
private let kChannelViewH : CGFloat = kScreenWidth * 1.8 / 8


class AmuseViewController: UIViewController {

    /// collectionView
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = kMargin
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.sectionInset = UIEdgeInsetsMake(0, kMargin, 0, kMargin)
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderHeight)
        layout.itemSize = CGSize(width : kItemWidth,height : kItemHeight)
        
        let collectionView = UICollectionView(frame: (self.view.bounds), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        /// 注册单元格
        collectionView.register(UINib.init(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kRecomendCell)
        
        /// 注册头视图
        collectionView.register(UINib(nibName: "RecomandHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kAmuseHeaderView)
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        
        //设置内边距
        collectionView.contentInset = UIEdgeInsets(top: kTopHeaderH, left: 0, bottom: 0, right: 0)
        
        return collectionView
        }()
    
    /// 懒加载topHeaderView
    fileprivate lazy var amuseView : AmuseHeaderView = {
        
        let amuseView = AmuseHeaderView.viewFromNib()
        amuseView.frame = CGRect(x: 0, y: -kTopHeaderH, width: kScreenWidth, height: kTopHeaderH)
        
        return amuseView
         
    }()
    
    // MARK:jiaz视图
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        
        collectionView.addSubview(amuseView)
    
    }


    
}

// MARK: 代理协议
extension AmuseViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecomendCell, for: indexPath) as! CollectionNormalCell
        
        
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kAmuseHeaderView, for: indexPath)
        
        
        return headerView
        
    }
    
    
}




