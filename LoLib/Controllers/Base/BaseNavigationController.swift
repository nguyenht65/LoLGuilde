//
//  BaseNavigationController.swift
//  LoLib
//
//  Created by Bang on 02/12/2021.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        UINavigationBar.appearance().backgroundColor = UIColor(named: Color.backgroundColor.rawValue)
        UINavigationBar.appearance().barTintColor = UIColor(named: Color.backgroundColor.rawValue)
    }
}
