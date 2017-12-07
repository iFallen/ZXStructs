//
//  UIDevice+ZX.swift
//  ZXStructs
//
//  Created by JuanFelix on 2017/4/1.
//  Copyright © 2017年 JuanFelix. All rights reserved.
//

import UIKit

public enum ZX_DeviceSizeType {
    case s_4_0Inch,s_4_7Inch,s_5_5_Inch,s_5_8_Inch,s_iPad
    
    public func description() -> String {
        switch self {
            case .s_4_0Inch:
                return "<=4.0Inch"
            case .s_4_7Inch:
                return "4.7Inch"
            case .s_5_5_Inch:
                return "5.5Inch"
            case .s_5_8_Inch:
                return "5.8Inch"
            case .s_iPad:
                return ">= 5.5Inch"
        }
    }
}

extension UIDevice {
    public static var zx_isiPhone: Bool { return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) }
    public static var zx_isiPad: Bool { return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) }
    public class func zx_DeviceSizeType() -> ZX_DeviceSizeType {
        if self.zx_isiPhone {
            let length = max(UIScreen.zx_width, UIScreen.zx_height)
            if length <= 568.0 {
                return ZX_DeviceSizeType.s_4_0Inch
            } else if length <= 667 {
                return ZX_DeviceSizeType.s_4_7Inch
            } else if length <= 736 {
                return ZX_DeviceSizeType.s_5_5_Inch
            } else {
                return ZX_DeviceSizeType.s_5_8_Inch
            }
        }else{
            return ZX_DeviceSizeType.s_iPad
        }
    }
}
