//
//  HomeChannelView.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/12.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//  频道View

import UIKit

private let kChannelCellID = "kChannelCellID"


class HomeChannelView: UIView {

    /// 频道布局
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    /// 频道collectionView
    @IBOutlet weak var channelCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.channelCollectionView.register(UINib(nibName: "CollectionChannelCell", bundle: nil), forCellWithReuseIdentifier: kChannelCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout.itemSize = CGSize(width: frame.width * 0.22, height: self.frame.height)
        
    }
    
    
    
    /// 频道模型数组
    public var channelModels : [BaseLiveGroupModel]?{
        
        didSet{
            // 刷新collectionView
            channelCollectionView.reloadData()
        }
    }


}
// MARK: 代理协议
extension HomeChannelView : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channelModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kChannelCellID, for: indexPath) as! CollectionChannelCell
        let model = channelModels![indexPath.item]
        cell.channelModel = model
        
        return cell
        
    }
    
}

extension HomeChannelView {

    class func viewFromNib() -> HomeChannelView {
        
        return Bundle.main.loadNibNamed("HomeChannelView", owner: nil, options: nil)?.first as! HomeChannelView
    }
    
    
}

