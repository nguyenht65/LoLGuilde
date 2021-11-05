//
//  ChampionsViewController.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

protocol ChampionsViewProtocol {
    func getChampionsSuccess()
}

class ChampionsViewController: BaseViewController, ChampionsViewProtocol {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var championsTableView: UITableView!
    private let championsViewModel: ChampionsViewModel = ChampionsViewModel()
    let disposeBag = DisposeBag()
    
    func getChampionsSuccess() {
        self.championsTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        championsViewModel.championView = self
        onSearching()
    }

    override func setupUI() {
        let nib = UINib(nibName: ChampionsCell.className, bundle: .main)
        championsTableView.register(nib, forCellReuseIdentifier: "cell")
        championsTableView.delegate = nil
        championsTableView.dataSource = nil
    }

    override func setupData() {
        championsViewModel.loadAPI()
        championsViewModel.readChampionsCache()
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
                if query.isEmpty {
//                    return .just([])
                    return self.allChampions()
                }
                return self.searchChampions(query)
            }
            .observe(on: MainScheduler.instance)

        searchResults
            .bind(to: championsTableView.rx.items(cellIdentifier: "cell", cellType: ChampionsCell.self)) {
                (index, champions: Champion, cell) in
//                guard let cell = cell as? ChampionsCell else { return }
                cell.setupData(item: champions)
            }
            .disposed(by: disposeBag)
    }
    
    func searchChampions(_ query: String) -> Observable<[Champion]> {
        let listChampions: [Champion] = championsViewModel.champions.value
            .filter{ ($0.name ?? "").uppercased().contains(query.uppercased()) }
        return Observable.of(listChampions)
    }
    
    func allChampions() -> Observable<[Champion]> {
        let listChampions: [Champion] = championsViewModel.champions.value
        return Observable.of(listChampions)
    }
    
}

extension ChampionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return championsViewModel.champions.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChampionsCell
        let item = championsViewModel.champions.value[indexPath.row]
        cell.setupData(item: item)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = championsViewModel.champions.value[indexPath.row]

        let championInfoVC = ChampionInfoViewController()
        let urlStringImage = "https://nguyenht65.github.io/LOLResources/LoLResouces/lol/img/champion/\(item.image?.full ?? "")"
        championInfoVC._urlStringImage = urlStringImage
        championInfoVC.champion = item
        self.navigationController?.pushViewController(championInfoVC, animated: true)
    }
}
