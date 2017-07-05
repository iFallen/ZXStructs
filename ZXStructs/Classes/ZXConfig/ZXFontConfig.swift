//
//  ZXFontConfig.swift
//  ZXStructs
//
//  Created by JuanFelix on 2017/4/1.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

public class ZXFontConfig: NSObject {
    //MARK: - Config Dic
    static var config: NSDictionary?
    public class func zxFontConfig() -> NSDictionary!{
        guard let cfg = config else {
            config = NSDictionary.init(contentsOfFile: Bundle.zx_fontConfigPath())!
            return config
        }
        return cfg
    }
    
    //MARK: - Font Name
    public class var fontNameTitle:String! {
        return configStringValue(forKey: "zx_fontNameTitle", defaultValue:"Arial")
    }
    
    public class var fontNameBody:String! {
        return configStringValue(forKey: "zx_fontNameBody", defaultValue:"Arial")
    }
    
    public class var fontNameMark:String! {
        return configStringValue(forKey: "zx_fontNameMark", defaultValue:"Arial")
    }
    
    public class var iconfontName:String! {
        return configStringValue(forKey: "zx_iconFont", defaultValue:"iconfont")
    }
    //MARK: - Font Size CGFloatValue
    
    public class var fontSizeTitle:CGFloat {
        return configFontSizeValue(forKey: "zx_fontSizeTitle", defaultSize: 15)
    }
    
    public class var fontSizeSubTitle:CGFloat {
        return configFontSizeValue(forKey: "zx_fontSizeSubtitle", defaultSize: 14)
    }
    
    public class var fontSizeBody:CGFloat {
        return configFontSizeValue(forKey: "zx_fontSizeBody", defaultSize: 13)
    }
    
    public class var fontSizeMark:CGFloat {
        return configFontSizeValue(forKey: "zx_fontSizeMark", defaultSize: 10)
    }
    
    //MARK: - Text Color Hex String
    
    public class var textColorTitle:String! {
        return configStringValue(forKey: "zx_textColorTitle", defaultValue: "#000000")
    }
    
    public class var textColorBody:String! {
        return configStringValue(forKey: "zx_textColorBody", defaultValue: "#3b3e43")
    }
    
    public class var textColorMark:String! {
        return configStringValue(forKey: "zx_textColorMark", defaultValue: "#9fa4ac")
    }
}

extension ZXFontConfig: ZXConfigValueProtocol {
    static func configStringValue(forKey key: String!, defaultValue: String!) -> String! {
        if let fontNameStr = (zxFontConfig().object(forKey: key) as? String), fontNameStr.characters.count > 0{
            return fontNameStr
        }
        return defaultValue
    }
    
    static func configFontSizeValue(forKey key:String,defaultSize:CGFloat) -> CGFloat {
        if let dicF = zxFontConfig().object(forKey: key) as? NSDictionary {
            switch UIDevice.zx_DeviceSizeType() {
            case .s_4_0Inch:
                return dicF.object(forKey: "4_0") as! CGFloat
            case .s_4_7Inch:
                return dicF.object(forKey: "4_7") as! CGFloat
            case .s_5_5_Inch:
                return dicF.object(forKey: "5_5") as! CGFloat
            default:
                return dicF.object(forKey: "5_5") as! CGFloat
            }
        }
        return defaultSize
    }
}
