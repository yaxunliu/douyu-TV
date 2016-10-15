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
    
    // 频道图片
    @IBOutlet weak var channelImageView: UIImageView!
    // 频道标题
    @IBOutlet weak var channelTitleLabel: UILabel!
    // 数据模型
    public var channelModel : BaseLiveGroupModel?{
        didSet{
         
            // 设置模型数据
            channelTitleLabel.text = channelModel?.tag_name
            
            let iconUrl = URL(string: channelModel?.icon_url ?? "")
                
            channelImageView.kf.setImage(with: iconUrl)
                
        }
    }
    

    

}
