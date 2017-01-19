//
//  MenuBarCell.swift
//  Youtube
//
//  Created by Lolita Chuang on 2017/1/18.
//  Copyright © 2017年 Child Woman. All rights reserved.
//

import UIKit

class MenuBarCell : BaseCell {
    
    /* 多餘的
    var icon : UIImage? {
        didSet {
            imageView.image = icon
        }
    }
    */
    
    let imageView : UIImageView = {
        let view = UIImageView()
        view.contentMode = UIViewContentMode.scaleAspectFill
        //view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    } ()
    
    /*
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red:91, green: 14, blue: 13)
        }
    }
    
    override var isSelected : Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red:91, green: 14, blue: 13)
        }
    }
    
    override func setupViews() {
        //backgroundColor = UIColor.yellow
        
        addSubview(imageView)
        addConstraintsWithFormat(format : "H:[v0(28)]", views: imageView)
        addConstraintsWithFormat(format : "V:[v0(28)]", views: imageView)
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
