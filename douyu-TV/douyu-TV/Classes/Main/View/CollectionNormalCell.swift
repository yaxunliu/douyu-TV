//
//  CollectionNormalCell.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/10.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit
import Kingfisher


class CollectionNormalCell: UICollectionViewCell {
    
    public var anchorM : AnchorModel?{
        didSet{
            
            guard let anchorM = anchorM else { return }
            
            let options : [KingfisherOptionsInfoItem] = [KingfisherOptionsInfoItem.transition(ImageTransition.flipFromTop(0.5))]
            
            // url的字符串
            let roomImage = anchorM.room_src
            let url = URL(string: roomImage)
            roomImageView.kf.setImage(with: url, placeholder: UIImage(named: "Img_default")!, options: options, progressBlock: nil, completionHandler: nil)

            // 设置主播昵称
            anchorNameLabel.text = anchorM.nickname
            // 设置主播所在城市
            liveTitleLabel.text = anchorM.room_name;
            
        }
    }

    /// 主播房间名称
    @IBOutlet weak var roomImageView: UIImageView!
    
    /// 直播内容标签
    @IBOutlet weak var liveTitleLabel: UILabel!
    /// 主播名称标签
    @IBOutlet weak var anchorNameLabel: UILabel!
    
    

}
