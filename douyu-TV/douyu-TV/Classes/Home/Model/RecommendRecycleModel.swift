//
//  RecycleModel.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/12.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//  推荐界面轮播图模型

import UIKit

class RecommendRecycleModel: NSObject {

    // 标题
    public var title = ""
    
    // 轮播图图片url
    public var pic_url = ""
    
    // 直播间模型即room
    public var live : BaseLiveModel = BaseLiveModel()
    
    
    // 房间模型
    var room : [String : NSObject]?{
        didSet{
            guard let liveRoom = room else { return }
              live = BaseLiveModel(dict: liveRoom)
        }
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}


