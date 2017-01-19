//
//  ViewController.swift
//  Youtube
//
//  Created by Lolita Chuang on 2017/1/16.
//  Copyright © 2017年 Child Woman. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {

    let menuBar : MenuBar = {
        let view = MenuBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgb(red:230, green:32, blue:31)
        
        return view
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        
        //collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId") //=> 再進化, 將UICollectionViewCell換成subclass
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        // 微調位置
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        self.navigationItem.title = "Home"
        self.navigationController?.navigationBar.isTranslucent = false // 不透明?
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home" // 有設定navigationItem.titleView則navigationItem.title就不會顯示
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        // titleView : Custom view to use in lieu of a title. May be sized horizontally. Only used when item is topmost on the stack => 利用這個property才能自訂字型, 顏色等
        self.navigationItem.titleView = titleLabel
        
        setupMenuBar()
    }
    
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }

}

// MARK: - UICollectionViewDataSource
extension HomeViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        
        //cell.backgroundColor = UIColor.red
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width - 16 * 2
        let height = width * 9 / 16
        
        return CGSize(width: collectionView.bounds.width, height: height + 16 + 68) // 這個設定和VideoCell分開了?
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //print("section:\(section)") => 印出section:0都在同一個section
        return 0 // => 使得cell之間沒有空隙, collectionView的背景灰色不會出現
    }
}
