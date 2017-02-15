//
//  MenuBar.swift
//  Youtube
//
//  Created by Lolita Chuang on 2017/1/18.
//  Copyright © 2017年 Child Woman. All rights reserved.
//

import UIKit

class MenuBar : UIView {
    let imageNames = ["home", "trending", "subscriptions", "account"/*, "profile"*/]
    
    // lazy let collectionView : UICollectionView = { // lazy需要搭配var
    lazy var collectionView : UICollectionView = {
        // let view = UICollectionView() // 造成crash, reason: 'UICollectionView must be initialized with a non-nil layout parameter
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.rgb(red:230, green:32, blue:31)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // 有設定layout's direction所以也不需要設定contentSize...?
        //view.contentSize = CGSize(width: view.frame.width/4*5, height: 50)
        view.showsHorizontalScrollIndicator = false
        
        // 造成error, 必須在let 前加入'lazy' :  That's an inbuilt feature in Swift to make sure that no ivar is used before its completely initialized. So, using lazy variable essentially makes sure that the self reference is only taken when the class is completely loaded, as lazy delays the initialization of the variable to only when it is actually required for use.
        view.delegate = self
        view.dataSource = self
        view.register(MenuBarCell.self, forCellWithReuseIdentifier: "menuBarCellId")
        
        return view
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0(50)]", views: collectionView)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        //collectionView.contentSize = CGSize(width: frame.width/4*CGFloat(imageNames.count), height: frame.height)
        
        // 可以將這些設定移至collectionView's initializer
        /*
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: "menuBarCellId")
        */
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuBar : UICollectionViewDelegate {
    
}

extension MenuBar : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // let cell = UICollectionViewCell() // crash, does not have a reuseIdentifier - cells must be retrieved by calling -dequeueReusableCellWithReuseIdentifier:forIndexPath:'
        let cell : MenuBarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuBarCellId", for: indexPath) as! MenuBarCell
        
        //cell.icon = UIImage(named:imageNames[indexPath.item])
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        
        
        return cell
    }
}

extension MenuBar : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: frame.width/4, height:frame.height)
    }
    
    // 給直向的間隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 給橫向的間隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// 似乎不需要再有一個subclass
//class MenuBarCollectionView : UICollectionView {
//    override init() {
//        super.init()
//        setupViews
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupViews() {
//        
//    }
//}
