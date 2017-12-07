//
//  ResuableView.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/4/19.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

public protocol ReuseableView: class {}

extension ReuseableView where Self: UIView {
    public var reuseIdentifier: String {
        return String(describing: self)
    }
}

public protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView {
    public var NibName: String {
        return String(describing: self)
    }
}


extension UITableViewCell: ReuseableView,NibLoadableView {}

extension UICollectionViewCell: ReuseableView,NibLoadableView {}

extension UITableViewHeaderFooterView: ReuseableView, NibLoadableView{}
