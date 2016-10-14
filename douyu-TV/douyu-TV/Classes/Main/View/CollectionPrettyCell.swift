//
//  CollectionPrettyCell.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/10.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//  颜值cell

import UIKit
import Kingfisher

class CollectionPrettyCell: UICollectionViewCell {

    
    var anchorM : AnchorModel?{
        didSet{
            
            guard let anchorM = anchorM else { return }
            // url的字符串
            let roomImage = anchorM.room_src
            let url = URL(string: roomImage)
            roomImageView.kf.setImage(with: url, placeholder: UIImage(named: "Img_default")!, options: nil, progressBlock: nil, completionHandler: nil)

            // 设置主播昵称
            anchorNameLabel.text = anchorM.nickname
            // 设置主播所在城市
            
            
        }
    }
    
    /// 直播房间图片
    @IBOutlet weak var roomImageView: UIImageView!
    /// 主播昵称
    @IBOutlet weak var anchorNameLabel: UILabel!
    /// 主播所在城市
    @IBOutlet weak var anchorCityLabel: UILabel!
    /// 在线人数
    @IBOutlet weak var onlineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
