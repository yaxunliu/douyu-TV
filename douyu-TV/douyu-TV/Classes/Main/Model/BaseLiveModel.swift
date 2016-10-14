//
//  AnchorModel.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/11.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//  基础直播间模型

import UIKit

class BaseLiveModel : NSObject {
    /// 房间id
    var room_id : String = ""
    /// 房间图片资源
    var room_src : String = ""
    /// 是否为手机直播 0 不是 1 是
    var isVertical : Int = 0
    /// 房间名称
    var room_name : String = ""
    /// 昵称
    var nickname : String = ""
    /// 游戏名称
    var game_name : String = ""
    /// 主播头像
    var avatar_small : String = ""
    
    
    override init() {
        super.init()
    }
    
    /// 构造函数
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
