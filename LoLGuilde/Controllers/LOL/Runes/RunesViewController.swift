//
//  RunesViewController.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import UIKit

protocol RunesViewProtocol {
    func getRunesSuccess()
}

class RunesViewController: BaseViewController, RunesViewProtocol {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var runesStackView: UIStackView!
    let runesViewModel: RunesViewModel = RunesViewModel()
    var runes: [Rune] = []

    func getRunesSuccess() {
        runes = runesViewModel.runes.value
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        segmentedControl.selectedSegmentTintColor = UIColor.systemYellow
    }

    override func setupData() {
        runesViewModel.loadAPI()
//        runesViewModel.readRunesCache()
 
    }

    @IBAction func selectedSegmentedControl(_ sender: UISegmentedControl) {
        for i in runesStackView.arrangedSubviews {
            i.removeFromSuperview()
        }
        let listRunes = runesViewModel.runes.value
        var view = UIView()
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            segmentedControl.selectedSegmentTintColor = UIColor.systemYellow
            view = PrecisionView(frame: runesStackView.bounds)
            (view as? PrecisionView)?.setupUI(item: listRunes[2])
        case 1:
            view = DominationView(frame: runesStackView.bounds)
            segmentedControl.selectedSegmentTintColor = UIColor.systemRed
            (view as? DominationView)?.setupUI(item: listRunes[0])
        case 2:
            view = SorceryView(frame: runesStackView.bounds)
            segmentedControl.selectedSegmentTintColor = UIColor.systemCyan
            (view as? SorceryView)?.setupUI(item: listRunes[4])
        case 3:
            view = ResolveView(frame: runesStackView.bounds)
            segmentedControl.selectedSegmentTintColor = UIColor.systemGreen
            (view as? ResolveView)?.setupUI(item: listRunes[3])
        case 4:
            view = InspirationView(frame: runesStackView.bounds)
            segmentedControl.selectedSegmentTintColor = UIColor.systemMint
            (view as? InspirationView)?.setupUI(item: listRunes[1])
        default:
            return
        }
        runesStackView.addArrangedSubview(view)
    }
}
