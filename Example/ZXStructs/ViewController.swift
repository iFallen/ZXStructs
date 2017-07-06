//
//  ViewController.swift
//  ZXStructs
//
//  Created by iFallen on 07/05/2017.
//  Copyright (c) 2017 iFallen. All rights reserved.
//

import UIKit
import ZXStructs

class ViewController: UIViewController {
    
    var scrollView:ZXAutoScrollView!
    lazy var imagePicker = {
        return ZXImagePickerUtils()
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
        
    }
    
    override func zx_rightBarButtonAction(index: Int) {
        if index == 0 {
            imagePicker.choosePhoto(presentFrom: self, completion: { (image, status) in
                
            })
        } else {
            imagePicker.takePhoto(presentFrom: self, completion: { (image, status) in
                
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

