//
//  BaseLiveModel.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/14.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//  直播分类最基本模型

import UIKit

class BaseLivesModel: NSObject {
    
    /// 名称
    var tag_name : String = ""
    
    /// icon
    var icon_url : String = ""
    
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override init() {
        
    }
    
}
