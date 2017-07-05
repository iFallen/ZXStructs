//
//  UIDevice+ZX.swift
//  ZXStructs
//
//  Created by JuanFelix on 2017/4/1.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

public enum ZX_DeviceSizeType {
    case s_4_0Inch,s_4_7Inch,s_5_5_Inch,s_iPad
    
    public func description() -> String {
        switch self {
        case .s_4_0Inch:
            return "<=4.0Inch"
        case .s_4_7Inch:
            return "4.7Inch"
        case .s_5_5_Inch:
            return "5.5Inch"
        case .s_iPad:
            return ">= 5.5Inch"
        }
    }
}

public let ZX_IS_IPAD          = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
public let ZX_IS_IPHONE        = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)
public let ZX_BOUNDS_WIDTH     = UIScreen.main.bounds.size.width
public let ZX_BOUNDS_HEIGHT    = UIScreen.main.bounds.size.height

extension UIDevice {
    public class func zx_DeviceSizeType() -> ZX_DeviceSizeType {
        if ZX_IS_IPHONE {
            let length = max(ZX_BOUNDS_WIDTH, ZX_BOUNDS_HEIGHT)
            if length <= 568.0 {
                return ZX_DeviceSizeType.s_4_0Inch
            }else if length <= 667 {
                return ZX_DeviceSizeType.s_4_7Inch
            }else {
                return ZX_DeviceSizeType.s_5_5_Inch
            }
        }else{
            return ZX_DeviceSizeType.s_iPad
        }
    }
}
