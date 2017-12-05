//
//  ViewController.swift
//  ZXStructs
//
//  Created by iFallen on 07/05/2017.
//  Copyright (c) 2017 iFallen. All rights reserved.
//

import UIKit
import ZXStructs
import ZXAutoScrollView
import HImagePickerUtils

class ViewController: ZXUIViewController {
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbSubTitle: UILabel!
    
    @IBOutlet weak var lbBody: UILabel!
    
    @IBOutlet weak var lbMark: UILabel!
    
    @IBOutlet weak var lbIconFont: UILabel!
    
    var scrollView:ZXAutoScrollView!
    lazy var imagePicker = {
        return HImagePickerUtils()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let string = "hello,world"
        self.zx_addNavBarButtonItems(textNames: ["相册","拍照"], font: nil, color: UIColor.red, at: .right)
        scrollView = ZXAutoScrollView.init(frame: CGRect(x: 50, y: 100, width: ZX_BOUNDS_WIDTH - 100, height: 100))
        scrollView.delegate = self
        scrollView.dataSource = self
        self.view.addSubview(scrollView)
        
        self.view.backgroundColor = UIColor.zx_backgroundColor
        
        
        
        ZXNetwork.zx_asyncRequest(withUrl: "http://www.sojson.com/open/api/weather/json.shtml?city=北京", params: nil, method: .get, completion: { (obj, string) in
            print(obj ?? "")    // json objcet
            print(string ?? "") //string
        }, timeOut: { (msg) in
            print(msg)
        }) { (code, msg) in
            print(code,msg)
        }
        
        self.lbTitle.font = UIFont.zx_titleFont()
        self.lbTitle.text = "Title"
        self.lbTitle.textColor = UIColor.zx_titleColor
        
        self.lbSubTitle.font = UIFont.zx_subTitleFont(fix: -1)
        self.lbSubTitle.text = "SubTitle"
        self.lbSubTitle.textColor = UIColor.zx_customCColor
        
        self.lbBody.font = UIFont.zx_bodyFont(14)
        self.lbBody.text = "Body"
        self.lbBody.textColor = UIColor.zx_bodyColor
        
        self.lbMark.font = UIFont.zx_bodyFont(14)
        self.lbMark.text = "Mark"
        self.lbMark.textColor = UIColor.zx_markColor
        
        self.lbIconFont.font = UIFont.zx_iconFont(25, fix: 1) //size 26
        self.lbIconFont.text = "A\u{e673}B"
        self.lbIconFont.textColor = UIColor.zx_customBColor
    }
    
    override func zx_keyboardWillHide(duration dt: Double, userInfo: Dictionary<String, Any>) {
        
    }
    
    override func zx_rightBarButtonAction(index: Int) {
        if index == 0 {
            imagePicker.choosePhoto(presentFrom: self, completion: { (image, status) in
                print(status.description())
            })
        } else {
            imagePicker.takePhoto(presentFrom: self, completion: { (image, status) in
                print(status.description())
            })
        }
    }
}

extension ViewController: ZXAutoScrollViewDataSource {
    func zxAutoScrollView(_ scollView: ZXAutoScrollView, pageAt index: Int) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.white
        label.text = "Page:\(index + 1)"
        switch index {
            case 0:
                label.backgroundColor = UIColor.blue
            case 1:
                label.backgroundColor = UIColor.brown
            case 2:
                label.backgroundColor = UIColor.purple
            case 3:
                label.backgroundColor = UIColor.cyan
            case 4:
                label.backgroundColor = UIColor.gray
            default:
                label.backgroundColor = UIColor.black
        }
        return label
    }
    
    func numberofPages(_ inScrollView: ZXAutoScrollView) -> Int {
        return 5
    }
}

extension ViewController: ZXAutoScrollViewDelegate {
    func zxAutoScrolView(_ scrollView: ZXAutoScrollView, selectAt index: Int) {
        ZXAlertUtils.showAlert(withTitle: nil, message: "Selected At:\(index + 1)")
    }
}

