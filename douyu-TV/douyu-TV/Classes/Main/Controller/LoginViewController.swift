//
//  LoginViewController.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/10.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {

    /// xib视图属性
    @IBOutlet weak var wechat: UIButton!
    @IBOutlet weak var qq: UIButton!
    @IBOutlet weak var sina: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置边框颜色
        setupBorderColor()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

private extension LoginViewController {
    
    /// 设置边框颜色
    func setupBorderColor(){
        
        wechat.layer.borderColor = UIColor(r: 51.0, g: 188.0, b: 23.0).cgColor
        wechat.layer.borderWidth = 1.0
        
        qq.layer.borderColor = UIColor(r: 52.0, g: 139.0, b: 255.0).cgColor
        qq.layer.borderWidth = 1.0
        
        sina.layer.borderColor = UIColor(r: 243.0, g: 62.0, b: 62.0).cgColor
        sina.layer.borderWidth = 1.0
        
    }
    
}



