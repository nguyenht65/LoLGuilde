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
    let spellsViewModel: SpellsViewModel = SpellsViewModel()

    func getSpellsSuccess() {
        self.spellsCollectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        spellsViewModel.spellsView = self
    }

    override func setupUI() {
        let nib = UINib(nibName: SpellsCell.className, bundle: .main)
        spellsCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        spellsCollectionView.delegate = self
        spellsCollectionView.dataSource = self
    }

    override func setupData() {
        spellsViewModel.loadAPI()
        spellsViewModel.readItemsCache()
    }
}

extension SpellsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spellsViewModel.spells.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SpellsCell
        let item = spellsViewModel.spells.value[indexPath.row]
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

}
