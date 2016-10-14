//
//  PageContentView.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 16/10/9.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    
    /// 内容视图发生滚动
    func contentViewDidScroll(_ sourceIndex : Int ,targetIndex : Int , progress : CGFloat)
    
    
    
}

private let contentViewID = "contentViewID"

class PageContentView: UIView {
    
    //  MARK: ----- 懒加载collectionView
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection(rawValue: 1)!
        
        
        let collectionV : UICollectionView = UICollectionView(frame: self!.bounds, collectionViewLayout: layout)
        collectionV.dataSource = self
        collectionV.delegate = self
        collectionV.bounces = false
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.isPagingEnabled = true
        collectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentViewID)
        
        return collectionV
        
        }()

    
    // MARK:- ----- 构造函数
    init(frame: CGRect ,childVcs :[UIViewController] ,parentVc:UIViewController) {
        
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: ----- 定义属性
    var startOffsetx : CGFloat = 0
    fileprivate var isFrobitScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate!
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentVc : UIViewController?
    
    
    //  MARK: ----- 对外公开方法
    /// 设置当前下标
    open func setCurrentIndex(_ index : Int) {
    
        isFrobitScrollDelegate = true
        
        let offsetX = CGFloat(index) * collectionView.frame.size.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
    
    
    

    
    
    
    
}


// 设置UI信息
private extension PageContentView{
    
    func setupUI(){
        
        /// 1.添加所有的子控制器
        addAllChildVc()
        
        /// 2.添加collectionView
        addSubview(collectionView)
        
        
    }
    /// 添加所有的子控制器
    func addAllChildVc(){
        
        for childVc in childVcs{
            self.parentVc?.addChildViewController(childVc)
        }
        
    }

    
    
}

extension PageContentView : UICollectionViewDelegate{

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isFrobitScrollDelegate = false
        /// 开始滑动的x轴的位置
        startOffsetx = scrollView.contentOffset.x
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isFrobitScrollDelegate == true { return }
        
        /// 1.初始化需要获取到的值
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        var progress : CGFloat = 0
        
        /// 2.计算参数值
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = collectionView.frame.size.width
        
        if currentOffsetX > startOffsetx {// 左滑
            let radius = currentOffsetX / scrollViewW
            
            //源索引
            sourceIndex = Int(currentOffsetX / scrollViewW)
            //目标索引
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            if currentOffsetX - startOffsetx == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
            //进度
            progress = 1 - (CGFloat(targetIndex) - radius)
            
        }else{// 右滑
            //进度
            let radius = currentOffsetX / scrollViewW
            //目标索引
            targetIndex = Int(currentOffsetX / scrollViewW)
            //源索引
            sourceIndex = targetIndex + 1
            
            progress = CGFloat(sourceIndex) - radius
            
            
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
        }
        
        //3.通知代理
        delegate.contentViewDidScroll(sourceIndex, targetIndex: targetIndex, progress: progress)
        
    }

    
    
}

extension PageContentView : UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentViewID, for: indexPath)
        
        for view in cell.contentView.subviews{
            
            view.removeFromSuperview()
        }
        
        let vc = childVcs[indexPath.row]
        vc.view.frame = cell.bounds
        
        cell.contentView.addSubview(vc.view)
        
        return cell
        
    }

    
}


