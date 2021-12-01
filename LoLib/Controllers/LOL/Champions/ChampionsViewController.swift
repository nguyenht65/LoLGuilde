//
//  ChampionsViewController.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import UIKit
import RxSwift
import SDWebImage
import RxRelay

class ChampionsViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var championsTableView: UITableView!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!

    private var viewModel: ChampionsViewModel
    private let disposeBag = DisposeBag()

    init(championsViewModel: ChampionsViewModel) {
        self.viewModel = championsViewModel
        super.init(nibName: ChampionsViewController.className, bundle: .main)
    }

    required init?(coder: NSCoder) {
        fatalError("Error at ChampionsViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        let nib = UINib(nibName: ChampionsCell.className, bundle: .main)
        championsTableView.register(nib, forCellReuseIdentifier: ChampionsCell.className)
        championsTableView.rx.setDelegate(self).disposed(by: disposeBag)
        hideKeyboardWhenTappedAround()
    }

    override func setupData() {
//        viewModel.readChampionsFromCache()
        viewModel.loadAPI()
        bindViewModel()
    }

    func bindViewModel() {
        viewModel.searchResults
            .asObservable()
            .bind(to: championsTableView.rx.items(cellIdentifier: ChampionsCell.className, cellType: ChampionsCell.self)) {
                (_, champions: Champion, cell) in
                cell.setupData(item: champions)
            }
            .disposed(by: disposeBag)
        onSearching()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        registerKeyboardNotifications()
    }

    func onSearching() {
        viewModel.search(searchBar: searchBar)
    }

}

extension ChampionsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // setup data
        let item = viewModel.searchResults.value[indexPath.row]
        let championInfoVC = ChampionInfoViewController()
        championInfoVC.getChampion(champion: item)
        // push navigation
        self.navigationController?.pushViewController(championInfoVC, animated: true)
    }
}

extension ChampionsViewController {

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
//        championsTableView.contentInset.bottom = newBottomViewPadding
        bottomViewConstraint.constant = newBottomViewPadding
        searchBar.setShowsCancelButton(true, animated: true)
    }

    @objc func keyboardWillHide(notification: Notification) {
        bottomViewConstraint.constant = 65
        searchBar.setShowsCancelButton(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

}
