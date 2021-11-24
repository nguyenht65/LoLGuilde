//
//  SpellsViewController.swift
//  LoLGuilde
//
//  Created by Bang on 01/11/2021.
//

import UIKit
import RxSwift

class SpellsViewController: BaseViewController {

    @IBOutlet weak var spellsCollectionView: UICollectionView!

    private let disposeBag = DisposeBag()
    private var viewModel: SpellsViewModel
    lazy var spellsDetailView = SpellsDetailView()

    init(spellsViewModel: SpellsViewModelProtocol) {
        self.viewModel = spellsViewModel as! SpellsViewModel
        super.init(nibName: SpellsViewController.className, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("Error at SpellsViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        let nib = UINib(nibName: SpellsCell.className, bundle: .main)
        spellsCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        spellsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }

    override func setupData() {
//        viewModel.readItemsCache()
        viewModel.loadAPI()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.spells
            .asObservable()
            .bind(to: spellsCollectionView.rx.items(cellIdentifier: "cell", cellType: SpellsCell.self)) {
                (index, items: Spell, cell) in
                cell.setupData(item: items)
            }
            .disposed(by: disposeBag)
    }
}

extension SpellsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let collectionViewWidth = collectionView.bounds.width
           return CGSize(width: collectionViewWidth/4, height: collectionViewWidth/4)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        spellsCollectionView.deselectItem(at: indexPath, animated: true)
        // setupUI
        spellsDetailView.removeFromSuperview()
        let screenSize = collectionView.layer.bounds.size
        spellsDetailView = SpellsDetailView(frame: CGRect(x: 0, y: 0, width: screenSize.width * 3 / 4, height: 250))
        spellsDetailView.center = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
        // setupData
        let item = viewModel.spells.value[indexPath.row]
        spellsDetailView.setupData(item: item)
        self.view.addSubview(spellsDetailView)
    }

}
