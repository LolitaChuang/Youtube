//
//  ScrollViewController.swift
//  Youtube
//
//  Created by Lolita Chuang on 2017/2/15.
//  Copyright © 2017年 Child Woman. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("hey")
        self.navigationController?.navigationBar.topItem?.title = ""
        // self.navigationController?.navigationBar.topItem?.title = nil // not work
        // self.navigationItem.backBarButtonItem?.title = "hey" // not work
        
        view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
