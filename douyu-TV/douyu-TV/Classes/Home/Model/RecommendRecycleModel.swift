//
//  RecycleModel.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/12.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit

class RecycleModel: NSObject {

    // 标题
    public var title = ""
    
    // 轮播图图片url
    public var pic_url = ""
    
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}


