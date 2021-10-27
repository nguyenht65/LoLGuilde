//
//  HomeViewController.swift
//  LoLGuilde
//
//  Created by Bang on 20/10/2021.
//

import UIKit

class HomeViewController: BaseViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        title = "LoLGuilde"
    }
    
    override func setupData() {
        
    }
    

    @IBAction func moveToLOLButton(_ sender: UIButton) {
        let tabBarController = LOLTabBarController()
        self.navigationController?.pushViewController(tabBarController, animated: true)
    }
    
    
    @IBAction func moveToTFTButton(_ sender: Any) {
        let tabBarController = TFTTabBarController()
        self.navigationController?.pushViewController(tabBarController, animated: true)
    }
}

