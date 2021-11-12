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
    private var listRunes: [Rune] = []
    let runesViewModel: RunesViewModel = RunesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        segmentedControl.selectedSegmentTintColor = UIColor.systemYellow
        let precisionView = PrecisionView(frame: runesStackView.bounds)
        let precisionRune = runesViewModel.runes.value[2]
        precisionView.setupUI(item: precisionRune)
        runesStackView.addArrangedSubview(precisionView)
    }
    
    override func setupData() {
        runesViewModel.loadAPI()
        runesViewModel.readRunesCache()
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
