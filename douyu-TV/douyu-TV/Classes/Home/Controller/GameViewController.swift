//
//  GameViewController.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/12.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit

// MARK:定义标识符
fileprivate let kGameCollectionID = "kGameCollectionID"
fileprivate let kGameHeaderViewID = "kGameHeaderViewID"

// MARK:定义常量
fileprivate let kMargain : CGFloat = 10
fileprivate let kItemWidth : CGFloat = (kScreenWidth - kMargain * 2) / 3
fileprivate let kItemHeight : CGFloat = kItemWidth * 1.10
fileprivate let kCommonListH : CGFloat = kItemHeight * 0.9
fileprivate let kBottomH : CGFloat = kCommonListH * 1 / 6
fileprivate let kCollectHeaderH : CGFloat = 90
fileprivate let kCommonGameViewH : CGFloat = 90


class GameViewController: UIViewController {
    /// ViewModel 模型
    fileprivate lazy var gameViewModel : GameViewModel = GameViewModel()
    
    /// 懒加载
    fileprivate lazy var gameTopHeader : RecomandHeaderView = {
        
        let topHeader = RecomandHeaderView.viewFromNib()
        topHeader.moreBtn.isHidden = true
        topHeader.frame = CGRect(x: 0, y: -(kCollectHeaderH+kCommonGameViewH), width: kScreenWidth, height: kCollectHeaderH)
        topHeader.tagNameLabel.text = "常用"
        
        return topHeader
        
    }()
    fileprivate lazy var commonGameView : HomeChannelView = { [unowned self] in
        
        let commonGameV = HomeChannelView.viewFromNib()
        
        commonGameV.frame = CGRect(x: 0, y: -kCommonGameViewH, width: kScreenWidth, height: kCommonGameViewH)
        
        return commonGameV
        
    }()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
            // 1.布局
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: kItemWidth ,height : kItemHeight)
            layout.minimumLineSpacing = 1
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsetsMake(0, kMargain, 0, kMargain)
            layout.headerReferenceSize = CGSize(width : kScreenWidth ,height : kCollectHeaderH)
        
            // 2.collectionView
            let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.backgroundColor = UIColor.white
            collectionView.autoresizingMask = [.flexibleHeight]
            collectionView.contentInset = UIEdgeInsetsMake(kCollectHeaderH+kCommonGameViewH, 0, 0, 0)
            // 2.1注册cell
            collectionView.register(UINib.init(nibName: "CollectionChannelCell", bundle: nil), forCellWithReuseIdentifier: kGameCollectionID)
        
            collectionView.register(UINib(nibName: "RecomandHeaderView", bundle: nil), forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier:kGameHeaderViewID)
        
        return collectionView
        
        }()
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        // 1.设置UI信息
        setupUI()
        // 2.请求数据
        requestData()
        
        
    }

}

// MARK:设置UI信息 请求数据
extension GameViewController {

    fileprivate func setupUI() {
        
        /// 1.collectionView
        view.addSubview(collectionView)
        /// 2.添加顶部条
        collectionView.addSubview(gameTopHeader)
        /// 3.添加常用游戏列表
        collectionView.addSubview(commonGameView)
    }
    
    fileprivate func requestData() {
        
        gameViewModel.requestAllGameList { 
            // 1.取得数组
            self.commonGameView.channelModels = Array(self.gameViewModel.allGames[0..<10])
            // 2.刷新数据
            self.collectionView.reloadData()

        }
    }
    
}

// MARK: 代理协议
extension GameViewController : UICollectionViewDataSource , UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.allGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCollectionID, for: indexPath) as! CollectionChannelCell
        let model = gameViewModel.allGames[indexPath.item]
        cell.channelModel = model
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGameHeaderViewID, for: indexPath) as! RecomandHeaderView
        
        headerView.tagNameLabel.text = "全部"
        headerView.moreBtn.isHidden = true
        
        return headerView
    }
    
    
    
}
