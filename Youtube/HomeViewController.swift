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
    
    let videoStateController = VideoStateController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        
        //collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId") //=> 再進化, 將UICollectionViewCell換成subclass
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        // 微調位置
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        self.navigationItem.title = "Home"
        self.navigationController?.navigationBar.isTranslucent = false // 不透明? 會是黑色?
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home" // 有設定navigationItem.titleView則navigationItem.title就不會顯示
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        // titleView : Custom view to use in lieu of a title. May be sized horizontally. Only used when item is topmost on the stack => 利用這個property才能自訂字型, 顏色等
        self.navigationItem.titleView = titleLabel
        
        setupMenuBar()
        
        // prepare to populate talble of videos
        videoStateController.fetchVideos() {(startIndex:Int, endIndex:Int, isReloadNeeded:Bool) -> Void in
            DispatchQueue.main.async(execute: {
                self.collectionView?.reloadData()
                //self.collectionView?.reloadItems(at: <#T##[IndexPath]#>)
            })
        }
    }
    
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        let redBackgroundView = UIView()
        redBackgroundView.backgroundColor = UIColor.rgb(red:230, green:32, blue:31)
        redBackgroundView.translatesAutoresizingMaskIntoConstraints = false // 是要加這個設定, 下面的constraint才會生效
        
        //view.translatesAutoresizingMaskIntoConstraints = false 不能設定會使menuBar不見
        view.addSubview(redBackgroundView)
        view.addConstraintsWithFormat(format:"H:|[v0]|", views: redBackgroundView)
        view.addConstraintsWithFormat(format:"V:[v0(50)]", views: redBackgroundView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format:"H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format:"V:[v0(50)]", views: menuBar)


        // These methods return an inactive constraint of the form thisAnchor = otherAnchor + constant.
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }

}

// MARK: - UICollectionViewDataSource
extension HomeViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoStateController.videos.count()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        
        //cell.backgroundColor = UIColor.red
        let video = videoStateController.videos[indexPath.item]!
        
        cell.video = video
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width - 16 * 2
        let height = width * 9 / 16
        
        return CGSize(width: collectionView.bounds.width, height: height + 16 + 90) // 這個設定和VideoCell分開了?
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //print("section:\(section)") => 印出section:0都在同一個section
        return 0 // => 使得cell之間沒有空隙, collectionView的背景灰色不會出現
    }
}
