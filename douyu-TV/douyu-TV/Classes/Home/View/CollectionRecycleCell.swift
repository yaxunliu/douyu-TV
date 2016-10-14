//
//  CollectionRecycleCell.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/11.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//  轮播cell

import UIKit
import Kingfisher
class CollectionRecycleCell: UICollectionViewCell {
    
    /// 监听数据模型数据发生改变，cell的图片
    public var recycleM : RecommendRecycleModel? {
        didSet{
            guard let model = recycleM else { return }
            
            advertisementImageView.kf.setImage(with: URL(string : model.pic_url), placeholder: UIImage(named: "Img_default")!, options: nil, progressBlock: nil, completionHandler: nil)
            
        }
    }

    /// 广告图片
    @IBOutlet weak var advertisementImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
