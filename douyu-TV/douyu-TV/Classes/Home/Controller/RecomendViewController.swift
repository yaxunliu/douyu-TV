//
//  RecomendViewController.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/10.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//  推荐控制器

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

class RecomendViewController: UIViewController  {
    
    /// 懒加载属性
    fileprivate lazy var recommendVM = RecommendVM()
    /// 轮播视图
    fileprivate lazy var recyleView : RecycleView = {
        
        let recyleView = RecycleView.viewFromNib()
        recyleView.frame = CGRect(x: 0, y: -(kRecyViewH + kChannelViewH), width: kScreenWidth, height: kRecyViewH)
        
        return recyleView
    }()
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
    /// 频道视图
    fileprivate lazy var channelView : HomeChannelView = {
        
        let channelV = HomeChannelView.viewFromNib()
        channelV.frame = CGRect(x: 0, y: -kChannelViewH, width: kScreenWidth, height: kChannelViewH)
        
        return channelV
    }()
    
    // MARK: ------ 系统函数调用
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 1.添加UI信息
        setupUI()
        // 2.请求网络数据
        requestAllData()
        
       
    }

}

// MARK: 设置UI信息和请求网络数据
extension RecomendViewController {
    
    // MARK:1.设置UI信息
    fileprivate func setupUI(){
        // 1.1 添加collectionView
        view.addSubview(collectionView)
        
        // 1.2 添加轮播视图
        collectionView.addSubview(recyleView)
        
        // 1.3 添加频道视图
        collectionView.addSubview(channelView)
        
    }
    // MARK:2.请求网络数据
    fileprivate func requestAllData(){
        /// 2.1请求游戏数据
        recommendVM.requestData {
            /// 刷新collectionView数据
            self.collectionView.reloadData()
            /// 给频道cell赋值
            self.channelView.channelModels = self.recommendVM.channelList
        }
        
        /// 2.2轮播数据请求完成刷新轮播图
        recommendVM.requesrRecyleViewData {
            // 给轮播图数组赋值
            self.recyleView.recycleArrays = self.recommendVM.recycleList
        }
    }
    
}

// MARK: 代理协议
extension RecomendViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = self.recommendVM.gameList[section]
        
        return group.groups.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.recommendVM.gameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = recommendVM.gameList[indexPath.section]
        let anchor = group.groups[indexPath.item]
        
        if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecomendPrettyCell, for: indexPath) as! CollectionPrettyCell
            
            cell.anchorM = anchor
            
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecomendCell, for: indexPath) as! CollectionNormalCell
            cell.anchorM = anchor


        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        /// 取出headView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kRecomendHeader, for: indexPath) as! RecomandHeaderView
        let group = recommendVM.gameList[indexPath.section]
        
        if indexPath.section > 1{
            group.icon_url = "home_header_hot"
        }
        /// 取出模型进行赋值
        headerView.liveG = group
    
        return headerView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        if indexPath.section == 1 {
            return CGSize(width: kItemWidth, height: kPrettyCellH)
            
        }
        
        return CGSize(width: kItemWidth, height: kItemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        self.present(LoginViewController(), animated: true, completion: nil)
    }
    

    
}


