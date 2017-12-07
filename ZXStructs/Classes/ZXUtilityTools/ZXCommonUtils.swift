//
//  ZXCommonUtils.swift
//  YDY_GJ_3_5
//
//  Created by JuanFelix on 2017/4/19.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

public typealias ZXFaildCallBack = (_ code: Int,_ errorMsg: String) -> Void

extension URL {
    public struct zx {
        public static func openURL(_ urlstr:String,failedCallBack:ZXFaildCallBack?) {
            if let url = URL(string: urlstr) {
                if UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                } else {
                    failedCallBack?(-1, "无法访问")
                }
                
            } else {
                failedCallBack?(-2, "URL不存在")
            }
        }
        
        public static func call(_ tel:String,failedCallBack:ZXFaildCallBack?) {
            self.openURL("tel://\(tel)") { (code, msg) in
                failedCallBack?(code, msg)
            }
        }
    }
}

extension UIPasteboard {
    public static func pasteString() -> String {
        let pasteBoard = UIPasteboard.general
        return pasteBoard.string ?? ""
    }
    
    public static func copy(_ text:String!) {
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = text
    }
}
