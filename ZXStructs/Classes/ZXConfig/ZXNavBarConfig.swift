//
//  ZXNavBarConfig.swift
//  ZXStructs
//
//  Created by JuanFelix on 2017/4/1.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

public class ZXNavBarConfig: NSObject {
    //MARK: - Config Dic
    public static var config: NSDictionary?
    public class func zxNavBarConfig() -> NSDictionary!{
        guard let cfg = config else {
            config = NSDictionary.init(contentsOfFile: Bundle.zx_navBarConfigPath())!
            return config
        }
        return cfg
    }
    
    //MARK: - Bool Value
    public class var userSystemBackButton: Bool {
        return configBoolValue(forKey: "zx_userSystemBackButton", defaultValue: true)
    }
    
    public class var showSeparatorLine: Bool {
        return configBoolValue(forKey: "zx_showSeparatorLine", defaultValue: true)
    }
    
    public class var isTranslucent: Bool {
        return configBoolValue(forKey: "zx_isTranslucent", defaultValue: false)
    }
    //MARK: - Color Hex String
    public class var narBarColorStr: String {
        return configStringValue(forKey: "zx_navBarColor", defaultValue: "#ff0000")
    }
    
    public class var titleColorStr: String {
        return configStringValue(forKey: "zx_titleColor", defaultValue: "#ffffff")
    }
    
    public class var barButtonColor: String  {
        return configStringValue(forKey: "zx_barButtonColor", defaultValue: "#ffffff")
    }
    
    //MARK: - Font Size
    
    public class var titleFontSize: CGFloat {
        return configFontSizeValue(forKey: "zx_titleFontSize", defaultSize: 18)
    }
    
    public class var barButtonFontSize: CGFloat {
        return configFontSizeValue(forKey: "zx_barButtonFontSize", defaultSize: 16)
    }
    //MARK: - Nav Title Font
    public class var navTitleFontName: String! {
        return configStringValue(forKey: "zx_navTitleFont", defaultValue: "Arial")
    }
    
    public class func navTilteFont(_ size:CGFloat) -> UIFont! {
        return UIFont(name: navTitleFontName, size: size)
    }
}

extension ZXNavBarConfig: ZXConfigValueProtocol{
    public static func configStringValue(forKey key: String!, defaultValue: String!) -> String! {
        if let configStr = (zxNavBarConfig().object(forKey: key) as? String),configStr.characters.count > 0 {
            return configStr
        }
        return defaultValue
    }
    
    public static func configFontSizeValue(forKey key:String,defaultSize:CGFloat) -> CGFloat {
        if let dicF = zxNavBarConfig().object(forKey: key) as? NSDictionary {
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
    
    public static func configBoolValue(forKey key:String, defaultValue: Bool) -> Bool {
        if let boolValue = zxNavBarConfig().object(forKey: key) as? Bool {
            return boolValue
        }
        return defaultValue
    }
    
    public static func active(){
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.isTranslucent  = ZXNavBarConfig.isTranslucent
        navBarAppearance.barTintColor   = UIColor.zx_navBarColor
        navBarAppearance.tintColor      = UIColor.zx_navBarButtonColor
        
        navBarAppearance.titleTextAttributes = {[NSForegroundColorAttributeName: UIColor.zx_navBarTitleColor,NSFontAttributeName: ZXNavBarConfig.navTilteFont(ZXNavBarConfig.titleFontSize)]}()
        
        if !ZXNavBarConfig.showSeparatorLine {
            navBarAppearance.shadowImage = UIImage()
            navBarAppearance.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        }
        
        if !ZXNavBarConfig.userSystemBackButton {
            navBarAppearance.backIndicatorImage = Bundle.zx_navBackImage()
            navBarAppearance.backIndicatorTransitionMaskImage = Bundle.zx_navBackImage()
        }
    }
}
