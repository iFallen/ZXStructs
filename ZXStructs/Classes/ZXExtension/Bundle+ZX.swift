//
//  Bundle+ZX.swift
//  ZXStructs
//
//  Created by JuanFelix on 2017/3/31.
//  Copyright © 2017年 JuanFelix. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Bunble Extension
extension Bundle{
    public static var zxSettingBundle: Bundle {
        return Bundle.init(path: Bundle(for: ZXTintColorConfig.self).path(forResource: "ZXSettings", ofType: "bundle")!)!
    }
    
    public class func zx_tintColorConfigPath() -> String! {
        return zxSettingBundle.path(forResource: "ZXConfig/ZXTintColorConfig", ofType: "plist")
    }
    
    public class func zx_fontConfigPath() -> String! {
        return zxSettingBundle.path(forResource: "ZXConfig/ZXFontConfig", ofType: "plist")
    }
    
    public class func zx_navBarConfigPath() -> String! {
        return zxSettingBundle.path(forResource: "ZXConfig/ZXNavBarConfig", ofType: "plist")
    }
    
    public class func zx_tabBarConfigPath() -> String! {
        return zxSettingBundle.path(forResource: "ZXConfig/ZXTabBarConfig", ofType: "plist")
    }
    
    public class func zx_navBackImage() -> UIImage! {
        return UIImage(contentsOfFile: zx_navBackImageName())
    }
    
    public class func zx_navBackImageName() -> String! {
        let scale: Int = Int(UIScreen.main.scale)
        return zxSettingBundle.path(forResource: "zx_navback@\(scale)x", ofType: "png")!
    }
    
    
    /// Project Name
    public static var zx_projectName: String! {
        return self.main.infoDictionary!["CFBundleExecutable"] as! String
    }
    
    
    /// Version
    public static var zx_bundleVersion: String {
        return self.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    /// Build
    public static var zx_bundleBuild: String {
        return self.main.infoDictionary!["CFBundleVersion"] as! String
    }
    
    
    /// BundleId
    public static var zx_bundleId: String {
        return self.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
}
