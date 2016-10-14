//
//  NetworkTool.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/10.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//  网络请求工具的封装

import UIKit
import Alamofire

/// 定义网络请求方式
enum MethodType {
    case GET
    case POST
}


class NetworkTool {
    
    // MARK: --- 暴露给外界的方法
    
    
    
    /// 请求数据 默认返回的是json数据
    ///
    /// - parameter methodType:      请求方法类型
    /// - parameter urlString:       网络地址
    /// - parameter parameter:       请求参数
    /// - parameter responsCallBack: 请求数据回调的闭包
    class func requestJSONData (methodType : MethodType , urlString : String ,parameters : [String : NSString]? = nil , responsCallBack : @escaping (_ result : Any) -> ()){
        
        // 1.获取网络请求类型
        let type : HTTPMethod = methodType == MethodType.GET ? .get : .post
        
        // 2.发送网络请求
        Alamofire.request( urlString , method : type,parameters : parameters).responseJSON { (response) in
            // 3.取出结果
            guard let res = response.result.value else {
                print("error : \(response.result.error!)")
                return
            }
            // 4.回调闭包传值
            responsCallBack(result : res)
        }
        
    }
    

}
