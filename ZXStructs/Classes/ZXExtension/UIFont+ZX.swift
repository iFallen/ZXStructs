//
//  UIFont+ZX.swift
//  ZXStructs
//
//  Created by JuanFelix on 2017/4/1.
//  Copyright © 2017年 JuanFelix. All rights reserved.
//

import UIKit

extension UIFont {
    
    //MARK: - Font-Name
    public class var zx_titleFontName: String {
        return ZXFontConfig.fontNameTitle
    }
    
    public class var zx_bodyFontName: String {
        return ZXFontConfig.fontNameBody
    }
    
    public class var zx_markFontName: String {
        return ZXFontConfig.fontNameMark
    }
    
    public class var zx_iconFontName: String {
        return ZXFontConfig.iconfontName
    }
    
    //MARK: - Font-Size
    public class var zx_titleFontSize: CGFloat {
        return ZXFontConfig.fontSizeTitle
    }
    
    public class var zx_subTitleFontSize: CGFloat {
        return ZXFontConfig.fontSizeSubTitle
    }
    
    public class var zx_bodyFontSize: CGFloat {
        return ZXFontConfig.fontSizeBody
    }
    
    public class var zx_markFontSize: CGFloat {
        return ZXFontConfig.fontSizeMark
    }
    
    /// TitleFont
    ///
    /// - Parameters:
    ///   - size: Default TitleFontSize
    ///   - fix: -n or  +n (means  TitleFontSize +/- n)
    /// - Returns: UIFont
    public class func zx_titleFont(_ size:CGFloat = zx_titleFontSize,fix:CGFloat = 0) -> UIFont {
        return UIFont(name: ZXFontConfig.fontNameTitle, size: size + fix)!
    }
    
    /// SubTitleFont
    ///
    /// - Parameters:
    ///   - size: Default SubTitleFontSize
    ///   - fix: -n or  +n (means  SubTitleFontSize +/- n)
    /// - Returns: UIFont
    public class func zx_subTitleFont(_ size:CGFloat = zx_subTitleFontSize,fix:CGFloat = 0) -> UIFont {
        return UIFont(name: ZXFontConfig.fontNameTitle, size: size + fix)!
    }
    /// BodyFont
    ///
    /// - Parameters:
    ///   - size: Default BodyFontSize
    ///   - fix: -n or  +n (means  BodyFontSize +/- n)
    /// - Returns: UIFont
    public class func zx_bodyFont(_ size:CGFloat = zx_bodyFontSize,fix:CGFloat = 0) -> UIFont {
        return UIFont(name: ZXFontConfig.fontNameBody, size: size + fix)!
    }
    /// MarkFont
    ///
    /// - Parameters:
    ///   - size: Default MarkFontSize
    ///   - fix: -n or  +n (means  MarkFontSize +/- n)
    /// - Returns: UIFont
    public class func zx_markFont(_ size:CGFloat = zx_markFontSize,fix:CGFloat = 0) -> UIFont {
        return UIFont(name: ZXFontConfig.fontNameMark, size: size + fix)!
    }
    /// IconFont
    ///
    /// - Parameters:
    ///   - size: Default IconFontSize
    ///   - fix: -n or  +n (means  IconFontSize +/- n)
    /// - Returns: UIFont
    public class func zx_iconFont(_ size:CGFloat = zx_bodyFontSize,fix:CGFloat = 0) -> UIFont {
        return UIFont(name: ZXFontConfig.iconfontName, size: size + fix) ?? UIFont.systemFont(ofSize: size)
    }

}
