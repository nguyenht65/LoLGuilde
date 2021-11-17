//
//  ItemsViewController.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import UIKit
import RxSwift

protocol ItemsViewProtocol {
    func getItemsSuccess()
}

class ItemsViewController: BaseViewController, ItemsViewProtocol {

    @IBOutlet weak var itemSearchBar: UISearchBar!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    let disposeBag = DisposeBag()
    let viewModel: ItemsViewModel = ItemsViewModel()
    private var listSearchedItems: [Item] = []
    var itemsDetailView = ItemsDetailView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    func getItemsSuccess() {
        onSearching()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.itemView = self
    }

    override func setupUI() {
        let nib = UINib(nibName: ItemsCell.className, bundle: .main)
        itemCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        itemCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        registerKeyboardNotifications()
        hideKeyboardWhenTappedAround()
    }

    override func setupData() {
        viewModel.loadAPI()
//        viewModel.readItemsCache()
    }

    func onSearching() {
        let searchResults = itemSearchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[Item]> in
                if query.isEmpty { // case when use not search anythings
                    return self.getAllItems()
                }
                return self.searchItems(query) // case when use search the query
            }
            .observe(on: MainScheduler.instance)

        searchResults
            .bind(to: itemCollectionView.rx.items(cellIdentifier: "cell", cellType: ItemsCell.self)) {
                (index, items: Item, cell) in
                cell.setupData(item: items)
            }
            .disposed(by: disposeBag)
    }

    func searchItems(_ query: String) -> Observable<[Item]> {
        let listItems: [Item] = viewModel.items.value
            .filter{ ($0.name).uppercased().contains(query.uppercased()) }
        listSearchedItems = listItems
        return Observable.of(listItems)
    }

    func getAllItems() -> Observable<[Item]> {
        let listAllItems: [Item] = viewModel.items.value
        listSearchedItems = listAllItems
        return Observable.of(listAllItems)
    }

}

extension ItemsViewController: UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {

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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // setupUI
        let screenSize = collectionView.layer.bounds.size
        itemsDetailView = ItemsDetailView(frame: CGRect(x: 0, y: 0, width: screenSize.width * 3 / 4, height: 250))
        itemsDetailView.center = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
        // setupData
        let item = viewModel.items.value[indexPath.row]
        itemsDetailView.setupData(item: item)
        self.view.addSubview(itemsDetailView)
    }
}

extension ItemsViewController {

    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        // get bottom padding of the screen
        let window = SceneDelegate.shared().window
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0
        let newBottomViewPadding = keyboardSize.height - bottomPadding - itemSearchBar.bounds.height
        itemCollectionView.contentInset.bottom = newBottomViewPadding
    }

    @objc func keyboardWillHide(notification: Notification) {
        bottomViewConstraint.constant = 65
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}
