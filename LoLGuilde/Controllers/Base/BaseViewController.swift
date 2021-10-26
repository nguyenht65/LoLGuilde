//
//  BaseViewController.swift
//  LoLGuilde
//
//  Created by Bang on 20/10/2021.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
    }

    func setupData() {} // xử lý Data (load, fetch,..)

    func setupUI() {} // xử lý UI lúc khởi tạo VC

}
