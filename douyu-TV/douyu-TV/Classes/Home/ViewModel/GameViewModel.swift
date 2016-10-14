//
//  GameViewModel.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/12.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit

class GameViewModel {
    /// 懒加载属性
    lazy var allGames : [GameModel] = [GameModel]()
}

extension GameViewModel {
    
    /// 请求全部游戏列表
    public func requestAllGameList(finishCallBack : @escaping ()->() )  {
        
        NetworkTool.requestJSONData(methodType: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game") { (result) in
            
            // 1.转化数据
            guard let resultDict = result as? [String : NSObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 2.字典转模型
            for dict in dataArray {
                let gameModel = GameModel(dict: dict)
                self.allGames.append(gameModel)
            }

            // 3.block回调
            finishCallBack()
        }
        
        
    }
    
    /// 请求常用列表
    public func requestCommonList( finishCallBack  :@escaping ()->()) {
        let parameters = ["limit":"4","time": NSDate.getCurrentTimeInterval() as NSString,"offset":"0"]

        NetworkTool.requestJSONData(methodType: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&time=1476156622$offset=0", parameters: parameters) { ( result ) in
            

            // 1.转化数据类型
            guard let resultDict = result as? [String : Any] else { return }

            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 2.字典转模型
            for dict in dataArray {
                let model = LiveGroup(dict: dict)
                
            }
            
            // 3.闭包回调
            finishCallBack()
        }
      
        
        
    }
}
