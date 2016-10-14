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
private let kRecomendHeader = "kRecomendHeader"
private let kRecomendPrettyCell = "kRecomendPrettyCell"


/// 定义常量值
private let kMargin : CGFloat = 5
private let kItemWidth = (kScreenWidth - 3 * kMargin) / 2
private let kItemHeight = (kItemWidth * 3) / 4
private let kPrettyCellH = kItemWidth * 4 / 3
private let kHeaderHeight : CGFloat = 50
private let kRecyViewH : CGFloat = kScreenWidth * 3 / 8
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
        collectionView.register(UINib.init(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kRecomendPrettyCell)
        
        /// 注册头视图
        collectionView.register(UINib(nibName: "RecomandHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kRecomendHeader)
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        
        //设置内边距
        collectionView.contentInset = UIEdgeInsets(top: kRecyViewH + kChannelViewH, left: 0, bottom: 0, right: 0)
        
        return collectionView
        }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.randomColor()
        view.addSubview(collectionView)
    
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
    
    
}




