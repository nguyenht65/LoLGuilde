//
//  ItemsViewController.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import UIKit

protocol ItemsViewProtocol {
    func getItemSuccess()
}

class ItemsViewController: BaseViewController, ItemsViewProtocol {

    @IBOutlet weak var itemCollectionView: UICollectionView!
    let itemsViewModel: ItemsViewModel = ItemsViewModel()

    func getItemSuccess() {
        self.itemCollectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        itemsViewModel.itemView = self
    }

    override func setupUI() {
        let nib = UINib(nibName: ItemsCell.className, bundle: .main)
        itemCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
    }

    override func setupData() {
        itemsViewModel.loadAPI()
        itemsViewModel.readItemsCache()
    }

}

extension ItemsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsViewModel.items.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemsCell
        let item = itemsViewModel.items.value[indexPath.row]
        cell.setupData(item: item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let collectionViewWidth = collectionView.bounds.width
           return CGSize(width: collectionViewWidth/5, height: collectionViewWidth/5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
