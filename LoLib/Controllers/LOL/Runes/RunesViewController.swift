//
//  RunesViewController.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import UIKit
import RxSwift
import RxRelay

class RunesViewController: BaseViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var runesStackView: UIStackView!

    private let disposeBag = DisposeBag()
    private var viewModel: RunesViewModel

    private lazy var precisionView: PrecisionView = {
        let view = PrecisionView(frame: runesStackView.bounds)
        view.backgroundImageView.image = UIImage(named: Image.RuneBackground.precision.rawValue)
        view.setupUI(item: viewModel.runes.value[2])
        view.setupData(rune: viewModel.runes.value[2])
        return view
    }()
    private lazy var dominationView: DominationView = {
        let view = DominationView(frame: runesStackView.bounds)
        view.backgroundImageView.image = UIImage(named: Image.RuneBackground.domination.rawValue)
        view.setupUI(item: viewModel.runes.value[0])
        view.setupData(rune: viewModel.runes.value[0])
        return view
    }()
    private lazy var sorceryView: BaseRuneView = {
        let view = BaseRuneView(frame: runesStackView.bounds)
        view.backgroundImageView.image = UIImage(named: Image.RuneBackground.sorcery.rawValue)
        view.setupUI(item: viewModel.runes.value[4])
        view.setupData(rune: viewModel.runes.value[4])
        return view
    }()
    private lazy var resolveView: BaseRuneView = {
        let view = BaseRuneView(frame: runesStackView.bounds)
        view.backgroundImageView.image = UIImage(named: Image.RuneBackground.resolve.rawValue)
        view.setupUI(item: viewModel.runes.value[3])
        view.setupData(rune: viewModel.runes.value[3])
        return view
    }()
    private lazy var inspirationView: BaseRuneView = {
        let view = BaseRuneView(frame: runesStackView.bounds)
        view.backgroundImageView.image = UIImage(named: Image.RuneBackground.inspiration.rawValue)
        view.setupUI(item: viewModel.runes.value[1])
        view.setupData(rune: viewModel.runes.value[1])
        return view
    }()

    init(runesViewModel: RunesViewModel) {
        self.viewModel = runesViewModel
        super.init(nibName: RunesViewController.className, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("Error at RunesViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        segmentedControl.selectedSegmentTintColor = UIColor.systemYellow
    }

    override func setupData() {
        viewModel.readRunesFromCache()
        viewModel.loadAPI()
        bindViewModel()
    }

    func bindViewModel() {
        viewModel.runes
            .asObservable()
            .subscribe(onNext: { [weak self] element in
                guard let self = self else { return }
                if !element.isEmpty {
                let view = self.precisionView
                self.runesStackView.addArrangedSubview(view)
                }
            })
            .disposed(by: disposeBag)
    }

    @IBAction func selectedSegmentedControl(_ sender: UISegmentedControl) {
        for view in runesStackView.arrangedSubviews {
            view.removeFromSuperview()
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
