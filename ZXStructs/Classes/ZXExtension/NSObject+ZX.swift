//
//  NSObject+ZX.swift
//  ZXStructs
//
//  Created by JuanFelix on 2017/4/7.
//  Copyright © 2017年 screson. All rights reserved.
//

import Foundation

public extension NSObject{
    public var zx_className: String {
        return String(describing: type(of: self))
    }
    public class var zx_className: String{
        return NSStringFromClass(type(of: self) as! AnyClass).components(separatedBy: ".").last!
    }
}
