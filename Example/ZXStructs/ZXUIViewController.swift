//
//  ZXUIViewController.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/4/20.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
import ZXStructs

class ZXUIViewController: UIViewController {
    
    var firstLoad = true
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.zx_clearNavbarBackButtonTitle()
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.zx_clearNavbarBackButtonTitle()
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.zx_emptyColor
        
        if let navBar = self.navigationController?.navigationBar {
            navBar.layer.shadowRadius = 1
            navBar.layer.shadowColor = UIColor.black.cgColor
            navBar.layer.shadowOpacity = 0.3
            navBar.layer.shadowOffset = CGSize(width: 0, height: 1)
            navBar.layer.shadowPath = UIBezierPath(rect: navBar.bounds).cgPath
        }
    }
    
    func showNavBarShadow(_ show:Bool) {
        if let navBar = self.navigationController?.navigationBar {
            if show {
                navBar.layer.shadowColor = UIColor.black.cgColor
            } else {
                navBar.layer.shadowColor = UIColor.clear.cgColor
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override open var prefersStatusBarHidden: Bool {
        return false
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent}
}



