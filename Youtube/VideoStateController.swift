//
//  VideoStateController.swift
//  Youtube
//
//  Created by Lolita Chuang on 2017/1/24.
//  Copyright © 2017年 Child Woman. All rights reserved.
//

import Foundation

class VideoStateController {
    
//    fileprivate(set) var videos:[Video] = {
//        
//    }()
    
    static let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
    var videos:[Video]? {
        get {
            return _videos
        }
    }
    
    private var _videos:[Video]?
    
    init() {
    }
    
    //func fetchVideos(callback:(startIndex:Int, endIndex:Int) -> Void) {
    func fetchVideos(callback:((Int, Int, Bool) -> Void)?) {
        
    }
}
