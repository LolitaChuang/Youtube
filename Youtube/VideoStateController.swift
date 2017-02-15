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
    
    static let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")!
    var videos:SynchronizedArray<Video> {
        get {
            return _videos
        }
    }
    
    private var _videos = SynchronizedArray<Video>()
    
    init() {
    }
    
    //func fetchVideos(callback:(startIndex:Int, endIndex:Int) -> Void) {
    func fetchVideos(callback:((Int, Int, Bool) -> Void)?) {
        // static variable需要加上class name
        URLSession.shared.dataTask(with: VideoStateController.url) { (data, response, error) in
            if let unwrappedError = error {
                print(unwrappedError)
                return
            } else if data == nil {
                return
            }
            
            
            // for test
            /*
            if let str = String(data: data!, encoding: .utf8) {
                print(str)
                
            }
             */
            
            self.parseDataToVideo(data: data!, callback: callback)
        }.resume()
    }
    
    private func parseDataToVideo(data:Data, callback:((Int, Int, Bool) -> Void)?) {
        // 1. 注意class method, jsonObject可能會throws異常
        // 2. downcast為Array<Any>
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as! Array<Any> {
            //for (index, dict) in json.enumerated() {
                //print("item \(index) : \(dict)")
            //}
            
            for dict in json {
                let video = Video(video: dict as? [String:AnyObject])
                
                if video != nil {
                    self._videos.append(newElement: video!)
                }
            }
            
            //print("video count : \(self._videos.count())")
            
            // callback!(0, self._videos.count(), true)
            if let unwrappedCallback = callback {
                unwrappedCallback(0, self._videos.count(), true)
            }
            
        }
    }
}
