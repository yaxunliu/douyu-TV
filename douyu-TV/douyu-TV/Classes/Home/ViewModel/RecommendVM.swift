//
//  RecommendVM.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/11.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit

class RecommendVM {
    
    /// 所有直播的数组
    public lazy var gameList : [LiveGroup] = [LiveGroup]()
    /// 频道数组
    public lazy var channelList : [LiveGroup] = [LiveGroup]()
    /// 轮播图数组
    public lazy var recycleList : [RecycleModel] = [RecycleModel]()
    
    /// 懒加载属性
    fileprivate lazy var hotData : LiveGroup = LiveGroup()
    fileprivate lazy var prettyData : LiveGroup = LiveGroup()
    
}

// MARK:网络请求（推荐界面）
extension RecommendVM{
    
    /// 请求游戏组列表数据
    func requestData( finisLoadData:@escaping ()->()){
        /// 0.请求参数
        let parameters = ["limit":"4","time": NSDate.getCurrentTimeInterval() as NSString,"offset":"0"]
        
        /// 0.1.创建GCD组
        let disGroup = DispatchGroup()
        
        // 1.获取‘最热‘数据
        disGroup.enter()
        NetworkTool.requestJSONData(methodType: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: parameters) { ( result ) in
            /// 1.1.验证返回值是否有值
            guard let resultDict = result as? [String : NSObject] else { return }
            /// 1.2.取出数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            /// 1.3.创建一个直播数
            self.hotData.tag_name = "最热"
            self.hotData.icon_url = "home_header_hot"
            /// 1.4.字典转模型
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict);
                self.hotData.groups.append(anchor)
            }
            disGroup.leave()
        }
        
        // 2.获取’颜值‘数据
        disGroup.enter()
        NetworkTool.requestJSONData(methodType: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            /// 2.1.验证返回值是否有值
            guard let resultDict = result as? [String : NSObject] else { return }
            /// 2.1.取出数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            /// 2.2.创建一个直播数组

            self.prettyData.tag_name = "颜值"
            self.prettyData.icon_url = "columnYanzhiIcon_20x20_"
            /// 2.3.字典转模型
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict);
                self.prettyData.groups.append(anchor)
            }
            /// 2.4.添加到游戏列表中去
            disGroup.leave()
        }
        
        // 3.获取'游戏'数据http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&time=1476156622$offset=0
        disGroup.enter()
        NetworkTool.requestJSONData(methodType: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            /// 3.1.验证返回值是否有值
            guard let resultDic = result as? [String : NSObject] else { return }
            /// 3.2.取出数组
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else { return }
            /// 3.3.字典转模型
            for dict in dataArray {
                let live = LiveGroup(dict: dict)
                /// 3.4.添加到数组中去 
                self.channelList.append(live)
                self.gameList.append(live)
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
              
                let model = RecycleModel(dict: dic)
                self.recycleList.append(model)
            }
            // 回调闭包
            finisLoadData()
        }
    }
    
    
    
}
