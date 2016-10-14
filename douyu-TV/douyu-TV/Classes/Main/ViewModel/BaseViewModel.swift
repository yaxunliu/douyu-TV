//
//  BaseViewModel.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/14.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit


class BaseViewModel : NSObject{
    
    // 直播组数据
    lazy var liveGroupsData : [BaseLiveGroupModel] = [BaseLiveGroupModel]()
    // 直播间数组
    lazy var liveModelsData : [BaseLiveModel] = [BaseLiveModel]()
    
    
}

extension BaseViewModel {
    
    /// 请求直播组数组 [BaseLiveGroupModel]
    ///
    /// - parameter URLString:      网络地址
    /// - parameter parameters:     参数
    /// - parameter finishCallBack: 回调block
    func requestLiveGroupData(URLString : String , parameters : [String : NSString]? = nil , finishCallBack : @escaping() -> ()) {
        
        NetworkTool.requestJSONData(methodType: .GET, urlString: URLString, parameters: parameters) { (result) in
            // 取得结果
            guard let resultDict = result as? [String : Any] else { return }
            // 取得数组
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 字典转模型
            for dict in dataArray {
                let model = BaseLiveGroupModel(dict: dict)
                self.liveGroupsData.append(model)
            }
            // 完成回调
            finishCallBack()
        }
    }
    
    
    /// 请求直播间数组 [BaseLiveModel]
    ///
    /// - parameter URLString:      网址
    /// - parameter parameters:     参数
    /// - parameter finishCallBack: 回调函数
    func requestLiveRoomData(URLString : String , parameters : [String : NSString]? = nil , finishCallBack : @escaping() -> ()) {
        
        NetworkTool.requestJSONData(methodType: .GET, urlString: URLString, parameters: parameters) { (result) in
            // 取得结果
            guard let resultDict = result as? [String : Any] else { return }
            // 取得数组
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 字典转模型
            for dict in dataArray {
                let model = BaseLiveModel(dict: dict as! [String : NSObject])
                self.liveModelsData.append(model)
            }
            // 完成回调
            finishCallBack()
        }
    }
    
    
    
    
}
