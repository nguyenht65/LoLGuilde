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
        segmentedControl.selectedSegmentTintColor = UIColor.systemYellow
        let precisionView = PrecisionView(frame: runesStackView.bounds)
        runesStackView.addArrangedSubview(precisionView)
    }
    
    @IBAction func selectedSegmentedControl(_ sender: Any) {
        for i in runesStackView.arrangedSubviews {
            i.removeFromSuperview()
        }
        var view = UIView()
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            segmentedControl.selectedSegmentTintColor = UIColor.systemYellow
            view = PrecisionView(frame: runesStackView.bounds)
            print(segmentedControl.selectedSegmentIndex)
        case 1:
            view = DominationView(frame: runesStackView.bounds)
            segmentedControl.selectedSegmentTintColor = UIColor.systemRed
            print(segmentedControl.selectedSegmentIndex)
        case 2:
            view = SorceryView(frame: runesStackView.bounds)
            segmentedControl.selectedSegmentTintColor = UIColor.systemCyan
            print(segmentedControl.selectedSegmentIndex)
        case 3:
            view = ResolveView(frame: runesStackView.bounds)
            segmentedControl.selectedSegmentTintColor = UIColor.systemGreen
            print(segmentedControl.selectedSegmentIndex)
        case 4:
            view = InspirationView(frame: runesStackView.bounds)
            segmentedControl.selectedSegmentTintColor = UIColor.systemMint
            print(segmentedControl.selectedSegmentIndex)
        default:
            return
        }
        runesStackView.addArrangedSubview(view)
    }
}
