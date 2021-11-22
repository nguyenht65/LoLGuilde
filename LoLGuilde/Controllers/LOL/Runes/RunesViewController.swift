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
        let view = PrecisionView(frame: runesStackView.bounds)
        view.setupUI(item: listRunes[2])
        view.setupData(rune: listRunes[2])
        return view
    }()
    private lazy var dominationView: DominationView = {
        let view = DominationView(frame: runesStackView.bounds)
        view.setupUI(item: listRunes[0])
        view.setupData(rune: listRunes[0])
        return view
    }()
    private lazy var sorceryView: SorceryView = {
        let view = SorceryView(frame: runesStackView.bounds)
        view.setupUI(item: listRunes[4])
        view.setupData(rune: listRunes[4])
        return view
    }()
    private lazy var resolveView: ResolveView = {
        let view = ResolveView(frame: runesStackView.bounds)
        view.setupUI(item: listRunes[3])
        view.setupData(rune: listRunes[3])
        return view
    }()
    private lazy var inspirationView: InspirationView = {
        let view = InspirationView(frame: runesStackView.bounds)
        view.setupUI(item: listRunes[1])
        view.setupData(rune: listRunes[1])
        return view
    }()

    func getRunesSuccess() {
        listRunes = viewModel.runes.value
        let precisionView = PrecisionView(frame: runesStackView.bounds)
        precisionView.setupUI(item: listRunes[2])
        precisionView.setupData(rune: listRunes[2])
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
            segmentedControl.selectedSegmentTintColor = UIColor.systemYellow
            view = precisionView
        case 1:
            segmentedControl.selectedSegmentTintColor = UIColor.systemRed
            view = dominationView
        case 2:
            segmentedControl.selectedSegmentTintColor = UIColor.systemCyan
            view = sorceryView
        case 3:
            segmentedControl.selectedSegmentTintColor = UIColor.systemGreen
            view = resolveView
        case 4:
            segmentedControl.selectedSegmentTintColor = UIColor.systemMint
            view = inspirationView
        default:
            return
        }
        runesStackView.addArrangedSubview(view)
    }
}
