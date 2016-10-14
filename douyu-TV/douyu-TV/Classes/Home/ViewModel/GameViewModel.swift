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
    lazy var allGames : [BaseLiveGroupModel] = [BaseLiveGroupModel]()
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
                let gameModel = BaseLiveGroupModel(dict: dict)
                self.allGames.append(gameModel)
            }
            // 3.block回调
            finishCallBack()
        }
    }
}
