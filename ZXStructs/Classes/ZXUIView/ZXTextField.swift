//
//  ZXTextField.swift
//  ZXTextField
//
//  Created by screson on 2017/9/14.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

let ZXNUMBERS   = "[0-9]*"
let ZXALPHABET  = "[a-zA-Z]*"
let ZXCHARS     = "[0-9a-zA-Z]*"

public protocol ZXTextFieldDelegate:class {
    func textFieldDidReachTheMaxLength(_ textField: UITextField)
}

extension ZXTextFieldDelegate {
    func textFieldDidReachTheMaxLength(_ textField: UITextField){}
}


public enum ZXTextFieldType:UInt {
    case none = 0
    case number = 1     //数字
    case telNum         //1开头
    case alphabet       //字母
    case characters     //字母+数字
}

public class ZXTextField: UITextField {
    
    public  weak var zxDelegate:ZXTextFieldDelegate?
    
    public  var inputType:ZXTextFieldType = .none {
        didSet{
            switch inputType {
                case .number:
                    self.keyboardType = .numberPad
                case .telNum:
                    self.keyboardType = .numberPad
                    self.maxLength = 11
                case .alphabet,.characters:
                    self.keyboardType = .asciiCapable
                default:
                    self.keyboardType = .default
            }
        }
    }
    
    public var canCopyPaste:Bool = true
    
    @IBInspectable public var maxLength:Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialUI()
    }
    
    fileprivate func initialUI() {
        self.contentVerticalAlignment = .center
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        self.clearButtonMode = .whileEditing
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if let lView = lView {
            var lFrame = lView.frame
            lFrame.size.height = self.frame.height
            lView.frame = lFrame
        }
    }
    
    fileprivate var lView:UIView?
    public  func setLeftOffset(_ offset:CGFloat,color:UIColor = UIColor.clear) {
        if offset > 0 {
            self.leftViewMode = .always
            lView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: offset, height: self.frame.size.height))
            lView?.backgroundColor = color
            self.leftView = lView
            
        } else {
            self.lView = nil
            self.leftViewMode = .never
            self.leftView = nil
        }
    }
    
    public var placeholderColor:UIColor? {
        didSet {
            if let color = self.placeholderColor {
                self.setValue(color, forKeyPath: "_placeholderLabel.textColor")
            }
        }
    }
    
    fileprivate func loadNotification() {
        //NotificationCenter.default.addObserver(self, selector: #selector(textDidBeginEditing(_:)), name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(textDidEndEditing(_:)), name: NSNotification.Name.UITextFieldTextDidEndEditing, object: nil)
    }
    
    fileprivate func removeNotification() {
        //NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        //NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidEndEditing, object: nil)
    }
    
    override public func becomeFirstResponder() -> Bool {
        if self.inputType != .none {
            self.loadNotification()
        }
        return super.becomeFirstResponder()
    }
    
    override public func resignFirstResponder() -> Bool {
        self.removeNotification()
        return super.resignFirstResponder()
    }
    
    fileprivate func markedNSRange() -> NSRange? {
        if let markedRange = self.markedTextRange {
            let begining = self.beginningOfDocument
            let start = markedRange.start
            let end = markedRange.end
            let location = self.offset(from: begining, to: start)
            let length = self.offset(from: start, to: end)
            return NSMakeRange(location, length)
        }
        return nil
    }
    
    fileprivate var lastText:String?
    @objc fileprivate func textDidChange(_ notification:Notification) {
        if let textf = notification.object as? UITextField,textf == self {
            if let text = textf.text {
                if inputType == .none {
                    if maxLength > 0 {
                        if text.count == maxLength {
                            zxDelegate?.textFieldDidReachTheMaxLength(self)
                        } else if text.count > maxLength {
                            textf.text = text.substring(to: maxLength)
                        }
                    }
                } else {
                    if let selectedRange = textf.markedTextRange,textf.position(from: selectedRange.start, offset: 0) != nil {//存在高亮不处理
                        if let lastText = lastText {
                            self.lastText = self.clearText(lastText)
                        }
                        self.text = lastText
                        return
                    }
                    var newText = text
                    if let lastText = lastText {
                        if text.count > lastText.count {
                            newText = text.substring(from: lastText.count)
                        } else {
                            if text.isEmpty {
                                self.lastText = nil
                            } else {
                                self.lastText = newText
                            }
                            return
                        }
                    }
                    if newText.count > 0 {
                        switch inputType {
                        case .number,.telNum:
                            let predicate = NSPredicate.init(format: "SELF MATCHES %@",ZXNUMBERS)
                            if !predicate.evaluate(with: newText) {
                                textf.text = lastText
                            } else {
                                //newText.count == 1 [except paste action]
                                if inputType == .telNum,lastText == nil,newText.count == 1,newText != "1" {
                                    textf.text = nil
                                    lastText = nil
                                }
                            }
                        case .alphabet:
                            let predicate = NSPredicate.init(format: "SELF MATCHES %@",ZXALPHABET)
                            if !predicate.evaluate(with: newText) {
                                textf.text = lastText
                            }
                        case .characters:
                            let predicate = NSPredicate.init(format: "SELF MATCHES %@",ZXCHARS)
                            if !predicate.evaluate(with: newText) {
                                textf.text = lastText
                            }
                        default:
                            break
                        }
                        
                    } else {
                        lastText = nil
                    }
                    
                    if maxLength > 0 {
                        if text.count == maxLength {
                            zxDelegate?.textFieldDidReachTheMaxLength(self)
                        } else if text.count > maxLength {
                            textf.text = text.substring(to: maxLength)
                        }
                    }
                    
                    if let text2 = textf.text,!text2.isEmpty {
                        lastText = text2
                    }
                }
            }
        }
    }
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        //UIMenuController.shared.isMenuVisible = false
        //return false
        return canCopyPaste
    }
    override public func paste(_ sender: Any?) {
        if inputType != .none,let string = UIPasteboard.general.string,string.count > 0 {
            let regularString = self.clearText(string)
            UIPasteboard.general.string = regularString
        }
        super.paste(sender)
    }
    
    fileprivate func clearText(_ text:String) -> String {
            var regularString = text
            switch inputType {
                case .number,.telNum:
                    regularString = regularString.replacingOccurrences(of: "[^0-9]*", with: "", options: .regularExpression, range: regularString.startIndex..<regularString.endIndex)
                case .alphabet:
                    regularString = regularString.replacingOccurrences(of: "[^a-zA-Z]*", with: "", options: .regularExpression, range: regularString.startIndex..<regularString.endIndex)
                case .characters:
                    regularString = regularString.replacingOccurrences(of: "[^0-9a-zA-Z]*", with: "", options: .regularExpression, range: regularString.startIndex..<regularString.endIndex)
                default:
                    break
            }
        return regularString
    }
    
    deinit {
        self.removeNotification()
    }

}
