//
//  UIColor-Extension.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 16/10/9.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r : CGFloat ,g :CGFloat ,b : CGFloat) {
        
        self.init(colorLiteralRed: Float(r) / 255.0, green: Float(g) / 255.0, blue: Float(b) / 255.0, alpha: 1.0)
        
    }
    
}

