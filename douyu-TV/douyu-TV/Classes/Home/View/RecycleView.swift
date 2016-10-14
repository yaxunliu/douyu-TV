//
//  RecycleView.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/11.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//  轮播View


import UIKit

private let kRecycleID = "kRecycleID"


class RecycleView: UIView {
    
    fileprivate var timer : Timer?
    
    public var recycleArrays : [RecycleModel]?{
        
        didSet{
            /// 1.确保数组中一定有值
            guard recycleArrays != nil else { return }
            
            /// 2.刷新collectionView
            recycleCollectionView.reloadData()
            
            /// 3.设置pageControl
            pageControl.numberOfPages = recycleArrays?.count ?? 0
            
            let count = (recycleArrays?.count ?? 0) * 500
            /// 4.滚到中间的位置
            recycleCollectionView.scrollToItem(at: NSIndexPath(item: count , section: 0) as IndexPath, at: UICollectionViewScrollPosition.left, animated: false)
            /// 5.启动定时器
            invailateTimer()
            addNewTimer()
            
        }
    }
    
    /// 布局
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    /// collectionView
    @IBOutlet weak var recycleCollectionView: UICollectionView!
    /// 页面控制器
    @IBOutlet weak var pageControl: UIPageControl!
    
    // 设置collectionView的一些属性
    override func awakeFromNib() {
        super.awakeFromNib()
        // 1.注册类
        recycleCollectionView.register(UINib.init(nibName: "CollectionRecycleCell", bundle: nil), forCellWithReuseIdentifier: kRecycleID)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout.itemSize = CGSize(width: self.bounds.width, height: self.bounds.height)
    }

}
// MARK: 定时器的方法
extension RecycleView{
    
    /// 创建定时器
    fileprivate func addNewTimer() {

        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.launchTimer), userInfo: nil, repeats: true)
        
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
                
    }
    /// 启动定时器
    @objc fileprivate func launchTimer() {
    
        // 获取到当前的offsetX
        let currentIndex = Int(self.recycleCollectionView.contentOffset.x / self.bounds.width)
        let nextIndex = currentIndex + 1
        
        recycleCollectionView.scrollToItem(at:IndexPath(item: nextIndex, section: 0) , at: UICollectionViewScrollPosition.left, animated: true)
        
    }
    /// 销毁定时器
    fileprivate func invailateTimer() {
        
        timer?.invalidate()
        timer = nil
        
    }
    
}
// MARK: 从xib中加载view
extension RecycleView{
    
    /// 从xib中实例化view的类方法
    class func viewFromNib() -> RecycleView {
      return   Bundle.main.loadNibNamed("RecycleView", owner: nil, options: nil)?.first as!RecycleView
    }
    
}
// MARK: 代理协议
extension RecycleView : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (recycleArrays?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecycleID, for: indexPath) as! CollectionRecycleCell
        let index = indexPath.item % (recycleArrays?.count)!
        
        let model = recycleArrays![index]
        cell.recycleM = model
        return cell
    }
    /// 用户停止拖拽的时候创建新的定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addNewTimer()

    }
    /// 用户开始拖拽销毁定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        invailateTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let page = scrollView.contentOffset.x / scrollView.frame.width
        
        pageControl.currentPage = Int(page) % (recycleArrays?.count)!
  
    }

}
