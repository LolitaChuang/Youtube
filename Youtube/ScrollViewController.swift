//
//  ScrollViewController.swift
//  Youtube
//
//  Created by Lolita Chuang on 2017/2/15.
//  Copyright © 2017年 Child Woman. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {

    let scrollView:UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        
        return view
    }()
    
    let imageView:UIImageView = {
        let view = UIImageView(image: UIImage(named: "image.png"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.title = ""
        // self.navigationController?.navigationBar.topItem?.title = nil // not work
        // self.navigationItem.backBarButtonItem?.title = "hey" // not work
        
        view.backgroundColor = UIColor.white
        setupScrollView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setZoomScale()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        if view.window == nil {
            view = nil
        }
    }
    
    func setupScrollView() {
        view.addSubview(scrollView) // 先加為subview再設定其constraints
        view.addConstraintsWithFormat(format:"H:|[v0]|", views: scrollView)
        view.addConstraintsWithFormat(format:"V:|[v0]|", views: scrollView)
        
        scrollView.contentSize = CGSize(width: imageView.bounds.size.width, height: imageView.bounds.size.height)
        scrollView.addSubview(imageView)
        scrollView.contentOffset = CGPoint(x: 1000, y: 450)
        
        scrollView.delegate = self
        setupGestureRecognizer()
    }
    
    func setZoomScale() {
        scrollView.maximumZoomScale = 1.0
        scrollView.minimumZoomScale = min(scrollView.bounds.size.width/imageView.bounds.size.width, scrollView.bounds.size.height/imageView.bounds.size.height)
        scrollView.zoomScale = scrollView.minimumZoomScale //1.0 // 這是什麼功用?
        //scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        
        scrollView.layoutIfNeeded()
    }
    
    func handleDoubleTap(_ recognizer:UITapGestureRecognizer) {
        if scrollView.zoomScale > scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
    
    func setupGestureRecognizer() {
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ScrollViewController.handleDoubleTap(_:)))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapGestureRecognizer)
    }
    
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }
    
    // 很重要但被我忘記的設定
    // 設定正確zoom才能正常運作
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) { // any zoom scale changes
        print("zooming")
        if scrollView == self.scrollView {
            let imageViewSize = imageView.frame.size // bound or frame有差別嗎? Ans:有
            /*
             The frame value that your are reading changes purely as a side-effect of the transform change.
             bounds則不會因為transform而改變
             但scrollView's bounds origin則不時在改變, 移動到目前visible region
            */
            let scrollViewSize = scrollView.bounds.size
            print("zoom factor is \(scrollView.zoomScale)")
            print("imageView frame size : \(imageViewSize.width, imageViewSize.height)")
            print("imageView bounds size : \(imageView.bounds.size.width, imageView.bounds.size.height)")
            print("scrollView bounds size : \(scrollViewSize.width, scrollViewSize.height)")
            print("scrollView's content size : \(scrollView.contentSize.width, scrollView.contentSize.height)")
            
            let verticalPadding = (imageViewSize.height < scrollViewSize.height) ? (scrollViewSize.height - imageViewSize.height)/2 : 0
            let horizontalPadding = (imageViewSize.width < scrollViewSize.width) ? (scrollViewSize.width - imageViewSize.width)/2 : 0
            print("verticalPadding:\(verticalPadding)")
            print("horizontalPadding:\(horizontalPadding)")
            
            scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        }
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) { // scale
    }
}
