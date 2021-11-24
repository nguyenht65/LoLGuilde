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
    private var listRunes: BehaviorRelay<[Rune]> = BehaviorRelay<[Rune]>(value: [])

    private lazy var precisionView: PrecisionView = {
        let view = PrecisionView(frame: runesStackView.bounds)
        view.setupUI(item: viewModel.runes.value[2])
        view.setupData(rune: viewModel.runes.value[2])
        return view
    }()
    private lazy var dominationView: DominationView = {
        let view = DominationView(frame: runesStackView.bounds)
        view.setupUI(item: viewModel.runes.value[0])
        view.setupData(rune: viewModel.runes.value[0])
        return view
    }()
    private lazy var sorceryView: SorceryView = {
        let view = SorceryView(frame: runesStackView.bounds)
        view.setupUI(item: viewModel.runes.value[4])
        view.setupData(rune: viewModel.runes.value[4])
        return view
    }()
    private lazy var resolveView: ResolveView = {
        let view = ResolveView(frame: runesStackView.bounds)
        view.setupUI(item: viewModel.runes.value[3])
        view.setupData(rune: viewModel.runes.value[3])
        return view
    }()
    private lazy var inspirationView: InspirationView = {
        let view = InspirationView(frame: runesStackView.bounds)
        view.setupUI(item: viewModel.runes.value[1])
        view.setupData(rune: viewModel.runes.value[1])
        return view
    }()

    init(runesViewModel: RunesViewModelProtocol) {
        self.viewModel = runesViewModel as! RunesViewModel
        super.init(nibName: RunesViewController.className, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("Error at RunessViewController")
    }

    func getRunesSuccess() {
//        listRunes = viewModel.runes.value
//        let precisionView = PrecisionView(frame: runesStackView.bounds)
//        precisionView.setupUI(item: listRunes[2])
//        precisionView.setupData(rune: listRunes[2])
//        runesStackView.addArrangedSubview(precisionView)
    }

    func bindViewModel() {
        viewModel.runes
            .asObservable()
//            .subscribe(onNext: { [weak self] element in
//                print(element[0])
//            })
            .bind(to: listRunes)
            .disposed(by: disposeBag)
//        let view = precisionView
//        runesStackView.addArrangedSubview(view)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        segmentedControl.selectedSegmentTintColor = UIColor.systemYellow
    }

    override func setupData() {
        viewModel.loadAPI()
//        viewModel.readRunesCache()
        bindViewModel()
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
