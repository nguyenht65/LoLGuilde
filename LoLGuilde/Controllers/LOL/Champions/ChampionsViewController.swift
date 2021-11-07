//
//  ChampionsViewController.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import UIKit
import RxSwift

protocol ChampionsViewProtocol {
    func getChampionsSuccess()
}

class ChampionsViewController: BaseViewController, ChampionsViewProtocol {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var championsTableView: UITableView!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    private let championsViewModel: ChampionsViewModel = ChampionsViewModel()
    let disposeBag = DisposeBag()
    private var listSearchedChampions: [Champion] = []

    func getChampionsSuccess() {
        self.championsTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        championsViewModel.championView = self
    }

    override func setupUI() {
        let nib = UINib(nibName: ChampionsCell.className, bundle: .main)
        championsTableView.register(nib, forCellReuseIdentifier: "cell")
        championsTableView.rx.setDelegate(self).disposed(by: disposeBag)
        registerKeyboardNotifications()
        hideKeyboardWhenTappedAround()
    }

    override func setupData() {
        championsViewModel.loadAPI()
        championsViewModel.readChampionsCache()
        onSearching()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    func onSearching() {
        let searchResults = searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[Champion]> in
                if query.isEmpty { // case when use not search anythings
//                    return .just([])
                    return self.getAllChampions()
                }
                return self.searchChampions(query) // case when use search the query
            }
            .observe(on: MainScheduler.instance)

        searchResults
            .bind(to: championsTableView.rx.items(cellIdentifier: "cell", cellType: ChampionsCell.self)) {
                (index, champions: Champion, cell) in
                cell.setupData(item: champions)
            }
            .disposed(by: disposeBag)
    }

    func searchChampions(_ query: String) -> Observable<[Champion]> {
        let listChampions: [Champion] = championsViewModel.champions.value
            .filter{ ($0.name ?? "").uppercased().contains(query.uppercased()) }
        listSearchedChampions = listChampions
        return Observable.of(listChampions)
    }

    func getAllChampions() -> Observable<[Champion]> {
        let listAllChampions: [Champion] = championsViewModel.champions.value
        listSearchedChampions = listAllChampions
        return Observable.of(listAllChampions)
    }
}

extension ChampionsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = listSearchedChampions[indexPath.row]

        let championInfoVC = ChampionInfoViewController()
        let urlStringImage = "https://nguyenht65.github.io/LOLResources/LoLResouces/lol/img/champion/\(item.image?.full ?? "")"
        championInfoVC._urlStringImage = urlStringImage
        championInfoVC.champion = item
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
        let newBottomViewPadding = keyboardSize.height - bottomPadding - searchBar.bounds.height
        championsTableView.contentInset.bottom = newBottomViewPadding
    }

    @objc func keyboardWillHide(notification: Notification) {
        bottomViewConstraint.constant = 65
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

}
