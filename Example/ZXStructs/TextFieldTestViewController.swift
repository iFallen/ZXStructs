//
//  TextFieldTestViewController.swift
//  ZXStructs
//
//  Created by JuanFelix on 2017/9/18.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import ZXStructs
import AdSupport

class TextFieldTestViewController: ZXUIViewController,ZXTextFieldDelegate {

    @IBOutlet weak var txtTel: ZXTextField!
    
    @IBOutlet weak var txtNumber: ZXTextField!
    
    @IBOutlet weak var txtAlpahbet: ZXTextField!
    
    @IBOutlet weak var textAlpa_Num: ZXTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.txtTel.inputType = .telNum
        self.txtTel.placeholder = "Tel:1xxx"
        self.txtTel.zxDelegate = self
        
        self.txtNumber.inputType = .number
        self.txtNumber.maxLength = 6
        self.txtNumber.placeholder = "Number"
        self.txtNumber.zxDelegate = self
        
        self.txtAlpahbet.inputType = .alphabet
        self.txtAlpahbet.maxLength = 20
         self.txtAlpahbet.placeholder = "Alphabet"
        self.txtAlpahbet.zxDelegate = self
        
        self.textAlpa_Num.inputType = .characters
        self.textAlpa_Num.placeholderColor = UIColor.yellow
        self.textAlpa_Num.placeholder = "A1"
        self.textAlpa_Num.setLeftOffset(3, color: UIColor.orange)
        
    }
    
    func textFieldDidReachTheMaxLength(_ textField: UITextField) {
        print("Input Done:\(textField.text!)")
    }
}
