//
//  AppDelegate.swift
//  Youtube
//
//  Created by Lolita Chuang on 2017/1/16.
//  Copyright © 2017年 Child Woman. All rights reserved.
//

import UIKit

/*
 GitHub Repositary :
 1. 在GitHub新增一個repositary
 2. Xcode -> Source Conrol -> Create Working Copy
 3. Configure 加入Remote repositary information
 4. 在terminal 執行 
    xcrun git config --global user.email you@yourdomain.com
    xcrun git config --global user.name "Your Name Here"
     讓Xcode相信你然後開啟helper function, Git? 還是因為要登入GitHub? 
*/


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let layout = UICollectionViewFlowLayout()
        window?.rootViewController = UINavigationController(rootViewController: HomeViewController(collectionViewLayout: layout))
        
        // navigation bar setting
        UINavigationBar.appearance().barTintColor = UIColor.rgb(red:230, green:32, blue:31)
        UINavigationBar.appearance().tintColor = UIColor.blue // 上面的字的顏色
        
        // navigation bar下方有陰影, 所以將之移除
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        
        application.statusBarStyle = .lightContent
        // status bar setting
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = UIColor.rgb(red:194, green: 31, blue: 31)
        statusBarBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        window?.addSubview(statusBarBackgroundView)
        
        // 錯誤, 應該由super view (container) 設定layout constraint
        //statusBarBackgroundView.addConstraintsWithFormat(format : "H:|[v0]|", views : statusBarBackgroundView)
        //statusBarBackgroundView.addConstraintsWithFormat(format : "V:|[v0(20)]", views : statusBarBackgroundView)
        window?.addConstraintsWithFormat(format : "H:|[v0]|", views : statusBarBackgroundView)
        window?.addConstraintsWithFormat(format : "V:|[v0(20)]", views : statusBarBackgroundView)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

