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
    
    // Apple's definition : Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence
    // 像是operator ovarloading : subscripts let you override the language-level square brackets [] usually used for accessing elements of a collection
    // Subscript definitions mix both function and computed property definition syntax
    subscript(index: Int) -> T? {
        get {
            var element:T?
            
            // 因為會有retain cycle 所以將self->weak, 但weak self可能為nil,  所以是一option
            queue.sync { [weak self] in
                element = self?.array?[index]
            }
            
            return element
        }
        
        //  There’s a default parameter newValue with a type that equals the subscript’s return type.
        set (newValue) {
            queue.async(flags:.barrier) { [weak self] in
                if let weakSelf = self, let unwrappedNewValue = newValue, var unwrappedArray = weakSelf.array {
                    
                     //unwrappedArray[index] = newValue // 因為subscript 傳入參數的型別和return type一樣
                    unwrappedArray[index] = unwrappedNewValue
                }
            }
        }
    }
}
