//
//  BaseCell.swift
//  Youtube
//
//  Created by Lolita Chuang on 2017/1/18.
//  Copyright © 2017年 Child Woman. All rights reserved.
//

import UIKit

class BaseCell : UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
    }
}
