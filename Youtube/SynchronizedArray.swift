//
//  SynchronizedArray
//  Youtube
//
//  Created by Lolita Chuang on 2017/1/25.
//  Copyright © 2017年 Child Woman. All rights reserved.
//

import Foundation

class SynchronizedArray<T> {
    //private var nsarray : NSArray? 可存在的型別
    private var array:[T]?
    private let queue = DispatchQueue(label: "SynchronizedArrayQueue", attributes:.concurrent)
    
    func append(newElement:T) {
        //     public func async(group: DispatchGroup? = default, qos: DispatchQoS = default, flags: DispatchWorkItemFlags = default, execute work: @escaping @convention(block) () -> Swift.Void)
        queue.async(flags:.barrier) { [weak self] in
            self?.array?.append(newElement)
        }
    }
    
    // protocol
    subscript(index: Int) -> T? {
        get {
            var element:T?
            
            // 因為會有retain cycle 所以將self->weak, 但weak self可能為nil,  所以是一option
            queue.sync { [weak self] in
                element = self?.array?[index]
            }
            
            return element
        }
        
        set {
            queue.async(flags:.barrier) { [weak self] in
                if let weakSelf = self, var unwrappedArray = weakSelf.array {
                    
                    // unwrappedArray[index] = newValue
                }
            }
        }
    }
}
