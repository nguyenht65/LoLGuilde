//
//  HomeViewController.swift
//  LoLGuilde
//
//  Created by Bang on 20/10/2021.
//

import UIKit

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.splashTimeOut(sender:)), userInfo: nil, repeats: false)
    }

    @objc func splashTimeOut(sender : Timer){
        SceneDelegate.shared().window?.rootViewController = TabBarController()
    }
}

