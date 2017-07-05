//
//  ZXStructs.swift
//  ZXStructs
//
//  Created by JuanFelix on 2017/4/1.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

public class ZXStructs: NSObject {
    public class func loadUIConfig()  {
        self.loadnavBarConfig()
        self.loadtabBarConfig()
    }
    
    public class func loadnavBarConfig() {
        ZXNavBarConfig.active()
    }
    
    public class func loadtabBarConfig() {
        ZXTabbarConfig.active()
    }
}
