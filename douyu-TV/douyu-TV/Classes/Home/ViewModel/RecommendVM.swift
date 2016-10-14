//
//  RecommendVM.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/11.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit

class RecommendVM :   BaseViewModel {
    
    /// 游戏 数组
    public lazy var gameList : [BaseLiveGroupModel] = [BaseLiveGroupModel]()
    
    /// 直播组模型 数组
    public lazy var channelList : [BaseLiveGroupModel] = [BaseLiveGroupModel]()
    
    /// 轮播图数组
    public lazy var recycleList : [RecommendRecycleModel] = [RecommendRecycleModel]()
    
    /// 懒加载属性
    fileprivate lazy var hotData : BaseLiveGroupModel = BaseLiveGroupModel()
    fileprivate lazy var prettyData : BaseLiveGroupModel = BaseLiveGroupModel()
    
    
}

// MARK:网络请求（推荐界面）
extension RecommendVM {
    /// 请求游戏组列表数据
    func requestData( finisLoadData:@escaping ()->()){
        /// 0.请求参数
        let parameters = ["limit":"4","time": NSDate.getCurrentTimeInterval() as NSString,"offset":"0"]
        /// 0.1.创建GCD组
        let disGroup = DispatchGroup()
        // 1.获取‘最热‘数据、
        disGroup.enter()
        requestLiveRoomData(URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: parameters) {
            self.hotData.tag_name = "最热"
            self.hotData.icon_url = "home_header_hot"
            for model in self.liveModelsData{
                self.hotData.roomList.append(model)
            }
            self.liveModelsData.removeAll()
            disGroup.leave()
        }
      
        // 2.获取‘颜值数据’
        disGroup.enter()
        requestLiveRoomData(URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) {
            // 1. 创建一个直播数组
            self.prettyData.tag_name = "颜值"
            self.prettyData.icon_url = "columnYanzhiIcon_20x20_"
            for model in self.liveModelsData{
                
                self.prettyData.roomList.append(model)
            }
            disGroup.leave()
        }
        
        // 3.获取'游戏'数据
        disGroup.enter()
    
        requestLiveGroupData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { 
            // 1. 创建一个直播数组
            self.prettyData.tag_name = "颜值"
            self.prettyData.icon_url = "columnYanzhiIcon_20x20_"
            for model in self.liveGroupsData{
                
                // 2.添加到数组中去
                self.channelList.append(model)
                self.gameList.append(model)
                
            }
            disGroup.leave()
        }
        
        disGroup.notify(queue: DispatchQueue.main) {
            self.gameList.insert(self.prettyData, at: 0)
            self.gameList.insert(self.hotData, at: 0)
            
            finisLoadData()
        }
        
    }
    
    /// 请求轮播数据  parameters: ["version" : "2.303"]
    func requesrRecyleViewData(finisLoadData :@escaping()->()){
        NetworkTool.requestJSONData(methodType: .GET, urlString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version":"2.303"]) { (result) in
            
            // 守护返回值
            guard let resultDict = result as? [String : NSObject] else { return }
            
            //
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            for dic in  dataArray {
              
                let model = RecommendRecycleModel(dict: dic)
                self.recycleList.append(model)
            }
            // 回调闭包
            finisLoadData()
        }
    }
    
    
    
}
