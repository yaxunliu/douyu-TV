//
//  NSDate-Extension.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/11.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import Foundation

public extension NSDate {
    
   class func getCurrentTimeInterval () -> String{
        
       let timeinterval =  Int(NSDate().timeIntervalSince1970)
        
        return "\(timeinterval)"
        
    }
    
}
