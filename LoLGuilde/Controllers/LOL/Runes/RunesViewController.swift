//
//  RunesViewController.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import UIKit

class RunesViewController: BaseViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var runesStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        var view = PrecisionView(frame: runesStackView.bounds)
        runesStackView.addArrangedSubview(view)
    }
    
    @IBAction func selectedSegmentedControl(_ sender: Any) {
        for i in runesStackView.arrangedSubviews {
            i.removeFromSuperview()
        }
        var view = UIView()
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            view = PrecisionView(frame: runesStackView.bounds)
            
            print(segmentedControl.selectedSegmentIndex)
        case 1:
            view = DominationView(frame: runesStackView.bounds)
            
            print(segmentedControl.selectedSegmentIndex)
        case 2:
            view = SorceryView(frame: runesStackView.bounds)
            
            print(segmentedControl.selectedSegmentIndex)
        case 3:
            view = ResolveView(frame: runesStackView.bounds)
            
            print(segmentedControl.selectedSegmentIndex)
        case 4:
            view = WhimsyView(frame: runesStackView.bounds)
            
            print(segmentedControl.selectedSegmentIndex)
        default:
            return
        }
        runesStackView.addArrangedSubview(view)
    }
}
