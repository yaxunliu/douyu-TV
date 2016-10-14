//
//  BaseLiveModel.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/14.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//  直播间组基础模型  ( 多个直播间的组合 )

import UIKit

class BaseLiveGroupModel: NSObject {
    
    // 转化好的模型数组即room_list
    var roomList :[BaseLiveModel] = [BaseLiveModel]()
    // 名称
    var tag_name : String = ""
    // icon
    var icon_url : String = ""
    // 直播间组
    var room_list : [[String : NSObject]]?{
        didSet{
            guard let rooms = room_list else { return }
            for dict in rooms {
                let model = BaseLiveModel(dict: dict)
                roomList.append(model)
            }
        }
    }
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override init() {
        
    }
    
}
