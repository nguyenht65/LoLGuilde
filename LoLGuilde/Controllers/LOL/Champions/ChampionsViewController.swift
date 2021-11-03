//
//  ChampionsViewController.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import UIKit

protocol ChampionsViewProtocol {
    func getChampionsSuccess()
}

class ChampionsViewController: BaseViewController, ChampionsViewProtocol {

    @IBOutlet weak var championsTableView: UITableView!
    private let championsViewModel: ChampionsViewModel = ChampionsViewModel()
    
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
        championsTableView.delegate = self
        championsTableView.dataSource = self
    }
    
    override func setupData() {
        championsViewModel.loadAPI()
        championsViewModel.readChampionsCache()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
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
        championInfoVC._name = item.name ?? ""
        championInfoVC._title = item.title ?? ""
        championInfoVC._tag = item.tags ?? []
        let urlStringImage = "https://nguyenht65.github.io/LOLResources/LoLResouces/lol/img/champion/\(item.image?.full ?? "")"
        championInfoVC._urlStringImage = urlStringImage
        self.navigationController?.pushViewController(championInfoVC, animated: true)
    }
}
