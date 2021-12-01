//
//  ItemsViewController.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import UIKit
import RxSwift

class ItemsViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!

    private let disposeBag = DisposeBag()
    private var viewModel: ItemsViewModel
    lazy var itemsDetailView = ItemsDetailView()

    init(itemsViewModel: ItemsViewModel) {
        self.viewModel = itemsViewModel
        super.init(nibName: ItemsViewController.className, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("Error at ItemsViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        let nib = UINib(nibName: ItemsCell.className, bundle: .main)
        itemCollectionView.register(nib, forCellWithReuseIdentifier: ItemsCell.className)
        itemCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        hideKeyboardWhenTappedAround()
    }

    override func setupData() {
        viewModel.readItemsFromCache()
        viewModel.loadAPI()
        bindViewModel()

    }

    func bindViewModel() {
        viewModel.searchResults
            .asObservable()
            .bind(to: itemCollectionView.rx.items(cellIdentifier: ItemsCell.className, cellType: ItemsCell.self)) {
                (_, items: Item, cell) in
                cell.setupData(item: items)
            }
            .disposed(by: disposeBag)
        onSearching()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }

    func onSearching() {
        viewModel.search(searchBar: searchBar)
    }
}

extension ItemsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

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
        itemsDetailView.removeFromSuperview()
//        let screenSize = collectionView.layer.bounds.size
        let screenSize: CGRect = UIScreen.main.bounds
        itemsDetailView.frame = CGRect(x: 0, y: 0, width: screenSize.width * 3 / 4, height: screenSize.height * 2 / 5)
        itemsDetailView.center = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
        // setupData
        let item = viewModel.searchResults.value[indexPath.row]
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
        let newBottomViewPadding = keyboardSize.height - bottomPadding
        bottomViewConstraint.constant = newBottomViewPadding
        searchBar.setShowsCancelButton(true, animated: true)
//        searchBar.setShowsScope(true, animated: true)
        itemsDetailView.removeFromSuperview()
    }

    @objc func keyboardWillHide(notification: Notification) {
        bottomViewConstraint.constant = 65
        searchBar.setShowsCancelButton(false, animated: true)
//        searchBar.setShowsScope(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}
