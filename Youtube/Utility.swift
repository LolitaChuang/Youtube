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

extension UIImageView {
    func loadImage(from url:URL) {
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        // 但此時UIImageView尚未被塞入image, size為0
        //print("(width, height) : (\(self.bounds.size.width), \(self.bounds.size.height))")
        indicatorView.center = self.center
        
        // 別忘了startAnimating
        indicatorView.hidesWhenStopped = true
        indicatorView.startAnimating()
        self.addSubview(indicatorView)
        
        /* test codes
        let view = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 30))
        view.backgroundColor = UIColor.red
        self.addSubview(view)
        */
        
        DispatchQueue.global().async {
            // 要記得加resume
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let unwrappedData = data, let image = UIImage(data: unwrappedData) {
                    // 要在main thread畫UI
                    DispatchQueue.main.async {
                        self.image = image
                        indicatorView.stopAnimating()

                    }
                }
            }).resume()
        }
        
    }
}
