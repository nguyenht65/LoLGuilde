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
    let viewModel: RunesViewModel = RunesViewModel()
    private var listRunes: [Rune] = []

    private lazy var precisionView: PrecisionView = {
        segmentedControl.selectedSegmentTintColor = UIColor.systemYellow
        let view = PrecisionView(frame: runesStackView.bounds)
        view.setupUI(item: listRunes[2])
        return view
    }()
    private lazy var dominationView: DominationView = {
        segmentedControl.selectedSegmentTintColor = UIColor.systemRed
        let view = DominationView(frame: runesStackView.bounds)
        view.setupUI(item: listRunes[0])
        return view
    }()
    private lazy var sorceryView: SorceryView = {
        segmentedControl.selectedSegmentTintColor = UIColor.systemCyan
        let view = SorceryView(frame: runesStackView.bounds)
        view.setupUI(item: listRunes[4])
        return view
    }()
    private lazy var resolveView: ResolveView = {
        segmentedControl.selectedSegmentTintColor = UIColor.systemGreen
        let view = ResolveView(frame: runesStackView.bounds)
        view.setupUI(item: listRunes[3])
        return view
    }()
    private lazy var inspirationView: InspirationView = {
        segmentedControl.selectedSegmentTintColor = UIColor.systemMint
        let view = InspirationView(frame: runesStackView.bounds)
        view.setupUI(item: listRunes[1])
        return view
    }()
    
    func getRunesSuccess() {
        listRunes = viewModel.runes.value
        let precisionView = PrecisionView(frame: runesStackView.bounds)
        precisionView.setupUI(item: listRunes[2])
        runesStackView.addArrangedSubview(precisionView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.runesView = self
    }

    override func setupUI() {
        segmentedControl.selectedSegmentTintColor = UIColor.systemYellow
    }

    override func setupData() {
        viewModel.loadAPI()
//        viewModel.readRunesCache()
    }

    @IBAction func selectedSegmentedControl(_ sender: UISegmentedControl) {
        for i in runesStackView.arrangedSubviews {
            i.removeFromSuperview()
        }
        var view = UIView()
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            view = precisionView
        case 1:
            view = dominationView
        case 2:
            view = sorceryView
        case 3:
            view = resolveView
        case 4:
            view = inspirationView
        default:
            return
        }
        runesStackView.addArrangedSubview(view)
    }
}
