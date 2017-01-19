//
//  Utility.swift
//  Youtube
//
//  Created by Lolita Chuang on 2017/1/17.
//  Copyright © 2017年 Child Woman. All rights reserved.
//

import UIKit

extension UIColor {
    // static 不能忘記加 : static and class both associate a method with a class, rather than an instance of a class. The difference is that subclasses can override class methods; they cannot override static methods.
    static func rgb(red : CGFloat, green : CGFloat, blue : CGFloat) -> UIColor {
            return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(format : String, views : UIView...) {
        var viewsDictionary = [String:UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
