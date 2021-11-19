//
//  SpellsViewController.swift
//  LoLGuilde
//
//  Created by Bang on 01/11/2021.
//

import UIKit

protocol SpellsViewProtocol {
    func getSpellsSuccess()
}

class SpellsViewController: BaseViewController, SpellsViewProtocol {

    @IBOutlet weak var spellsCollectionView: UICollectionView!
    let viewModel: SpellsViewModel = SpellsViewModel()
    lazy var spellsDetailView = SpellsDetailView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    func getSpellsSuccess() {
        self.spellsCollectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.spellsView = self
    }

    override func setupUI() {
        let nib = UINib(nibName: SpellsCell.className, bundle: .main)
        spellsCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        spellsCollectionView.delegate = self
        spellsCollectionView.dataSource = self
    }

    override func setupData() {
        viewModel.loadAPI()
//        viewModel.readItemsCache()
    }
}

extension SpellsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.spells.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SpellsCell
        let item = viewModel.spells.value[indexPath.row]
        cell.setupData(item: item)
        return cell
    }

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
