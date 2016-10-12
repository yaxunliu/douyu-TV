//
//  MainViewController.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 16/10/8.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.添加所有的子控制器
        addChildVc(storyName: "Home")
        addChildVc(storyName: "Live")
        addChildVc(storyName: "Follow")
        addChildVc(storyName: "Profile")

    
    }

    private func addChildVc(storyName: String){
        
        // 1.获取storyBoard
        let vc = UIStoryboard.init(name: storyName, bundle: nil).instantiateInitialViewController()
        
        // 2.添加为子控制器
        addChildViewController(vc!)
    
    }
}
