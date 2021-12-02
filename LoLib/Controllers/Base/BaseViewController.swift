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

    func setupData() { }

    func setupUI() { }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       AppUtility.lockOrientation(.portrait)
       // Or to rotate and lock
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
   }

   override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       // Don't forget to reset when view is being removed
       AppUtility.lockOrientation(.portrait)
   }

}
