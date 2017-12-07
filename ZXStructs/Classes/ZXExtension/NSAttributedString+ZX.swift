//
//  NSAttributeString+ZX.swift
//  ZXStructs
//
//  Created by JuanFelix on 2017/4/10.
//  Copyright © 2017年 JuanFelix. All rights reserved.
//

import UIKit

public enum ZXAttributedLineType {
    case underLine,deleteLine
}

extension NSAttributedString {
    public class func zx_lineFormat(_ text:String,type:ZXAttributedLineType,at range:NSRange) -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: text)
        switch type {
        case .deleteLine:
            attrString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSUnderlineStyle.patternSolid.rawValue|NSUnderlineStyle.styleSingle.rawValue, range: range)
        case .underLine:
            attrString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue , range: range)
        }
        return attrString
    }
    
    
    public class func zx_colorFormat(_ text:String,color:UIColor,at range:NSRange) -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: text)
        if range.length > 0 {
            attrString.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
        }
        return attrString
    }
    
    
    public class func zx_fontFormat(_ text:String,font:UIFont,at range:NSRange) -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: text)
        if range.length > 0 {
            attrString.addAttribute(NSAttributedStringKey.font, value: font, range: range)
        }
        return attrString
    }
}

extension NSMutableAttributedString {
    public func zx_appendColor(color:UIColor,at range:NSRange) {
        self.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
    }
    
    public func zx_appendFont(font:UIFont, at range:NSRange) {
        self.addAttribute(NSAttributedStringKey.font, value: font, range: range)
    }
}
