//
//  UIBarButtonItem-Extension.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 16/10/8.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    // 遍历构造函数
    convenience init(imageName:String, highImageName:String = "" ,itemSize:CGSize = CGSize(width: 0, height: 0)) {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        
        if (highImageName != "") {
            btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
        }
        
        if ((itemSize != CGSize(width: 0, height: 0))) {
            btn.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: itemSize)
        }else{
            btn.sizeToFit()
        }
        
        self.init(customView:btn)
        
    }
    
}
