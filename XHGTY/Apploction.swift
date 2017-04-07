//
//  Apploction.swift
//  bjscpk10
//
//  Created by shensu on 17/3/24.
//  Copyright © 2017年 shensu. All rights reserved.
//

import UIKit

class Apploction: NSObject {
    public static var `default` = Apploction()
    var userdefa = UserDefaults.standard
    var isLogin:Bool {
        get{
    return userdefa.bool(forKey: "isLogin")
        }
        set{
     userdefa.set(newValue, forKey: "isLogin")
        }
    }
    
    var userImage:UIImage? {
        get {
            let data = userdefa.value(forKey: "userImage") as? Data
            if data == nil {
            return nil 
            }
           
        return  UIImage.init(data: data!, scale: 1)
        }
        set{
            let data = UIImageJPEGRepresentation(newValue!, 0.5)
        return userdefa.set(data, forKey: "userImage")
        }
    }
    
}
