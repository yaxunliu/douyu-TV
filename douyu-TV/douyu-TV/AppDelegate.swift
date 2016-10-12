//
//  AppDelegate.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 16/10/8.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 设置tabBar上的item选中颜色
        UITabBar.appearance().tintColor = UIColor.orange
        
        
        
        return true
    }


}

