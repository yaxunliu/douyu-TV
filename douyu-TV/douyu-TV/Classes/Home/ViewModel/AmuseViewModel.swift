//
//  AmuseViewModel.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/14.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit

class AmuseViewModel: NSObject {

    // 菜单数组
    public var menuArray : [BaseLiveGroupModel] = [BaseLiveGroupModel]()
    
    
}


extension AmuseViewModel{
    
    func requestData(finishCallBack : @escaping ()->()) {
        
        NetworkTool.requestJSONData(methodType: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
            
            guard let resuleDict = result as? [String : Any] else { return }
            guard let dataArray = resuleDict["data"] else { return }
            
            
            
            finishCallBack()
        }
        
        
        
    }
    
}
