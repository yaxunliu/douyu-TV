//
//  CollectionChannelCell.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/12.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//  频道Cell

import UIKit
import Kingfisher

class CollectionChannelCell: UICollectionViewCell {
    
    /// 频道图片
    @IBOutlet weak var channelImageView: UIImageView!
    /// 频道标题
    @IBOutlet weak var channelTitleLabel: UILabel!
    
    
    
    /// 数据模型
    public var channelModel : ChannelModel?{
        
        didSet{
            /// 守护模型
            guard let model = channelModel else { return }
            
            /// 设置模型数据
            let image = ImageResource.init(downloadURL: URL(string: model.icon_url)!, cacheKey: model.icon_url)
            channelImageView.kf.setImage(with: image, placeholder: UIImage(named: "Image_column_default_44x44_"), options: nil, progressBlock: nil
                , completionHandler: nil)
            channelTitleLabel.text = model.tag_name
            
            
        }
    }
    
    /// 布局子视图
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        /// 设置圆角layer.masktoBounds
//        channelImageView.layer.masksToBounds = true
//        channelImageView.layer.cornerRadius = channelImageView.frame.width * 0.5
        channelImageView.layer.shouldRasterize = true 
        channelImageView.layer.rasterizationScale = 0.1
    }
    

}
