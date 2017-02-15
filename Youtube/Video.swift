//
//  Video.swift
//  Youtube
//
//  Created by Lolita Chuang on 2017/1/23.
//  Copyright © 2017年 Child Woman. All rights reserved.
//

//import UIKit
import Foundation

class Video:NSObject {
    // 最好保留個欄位的原型, 再由View決定如何呈現
    var thumbnailImageUrl:String?
    var title:String?
    var numberOfViews:String?
    var uploadDate:String?
    
    var channel: Channel?
    
    
    convenience override init() {
        self.init()
    }
    
    // 先初始化自己類別中的property, 再呼叫父親的designated initializer; 若順序顛倒會造成compiler error, 因為property沒有辦法被super.init()初始化
    init?(video:[String:AnyObject]?) {
        if let unwrappedVideo = video {
            // thumbnailImageUrl = video!["thumbnailImageUrl"]? as! String => 以as? 做conditional downcast
            thumbnailImageUrl = unwrappedVideo["thumbnail_image_name"] as? String ?? "default url"
            title = unwrappedVideo["title"] as? String ?? "default title"
            
            let number = unwrappedVideo["number_of_views"] as? Int ?? 0
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberOfViews = numberFormatter.string(for: number)
            
            let dateFormatter = DateFormatter()
            DateFormatter.dateFormat(fromTemplate: "EEE, dd MMM yyyy hh:mm:ss +zzzz", options: 0, locale: nil)
            uploadDate = unwrappedVideo["uploadDate"] as? String ?? dateFormatter.string(from: Date())
            
            channel = Channel(channel: unwrappedVideo["channel"] as? [String:AnyObject])
            
            super.init()
        } else {
            // failable initializer
            return nil
        }
    }
}

class Channel:NSObject {
    var name: String?
    var profileImageUrl: String?
    
    // 是可有可無的嗎?如果不override且不加convenience會不會讓其直接呼叫super's init而導致錯誤呢? => 是可有可無的, 因為繼承自parent但為designated, 所以要加上convenience 強迫先執行self designated init做初始化
    convenience override init() {
        self.init()
    }
    
    init?(channel:[String:AnyObject]?) {
        if let unwrappedChannel = channel {
            name = unwrappedChannel["name"] as? String ?? "default channel"
            profileImageUrl = unwrappedChannel["profile_image_name"] as? String ?? "default profile url"
            
            super.init()
        } else {
            return nil
        }
    }
}
