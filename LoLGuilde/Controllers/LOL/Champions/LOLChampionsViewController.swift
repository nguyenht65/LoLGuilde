//
//  LOLChampionsViewController.swift
//  LoLGuilde
//
//  Created by Bang on 27/10/2021.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import SDWebImage

class LOLChampionsViewController: BaseViewController {
    
    @IBOutlet weak var championsTableView: UITableView!
    
    private let urlChampion = "https://nguyenht65.github.io/LOLResources/LoLResouces/lol/data/en_US/champion.json"
    private let disposeBag = DisposeBag()
    //    private var champions = BehaviorRelay<[Champion]>(value: [])
    private var champions: [Champion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        let nib = UINib(nibName: "LOLChampionsCell", bundle: .main)
        championsTableView.register(nib, forCellReuseIdentifier: "cell")
        championsTableView.delegate = self
        championsTableView.dataSource = self
    }
    
    override func setupData() {
        loadAPI()
    }
    
    func loadAPI() {
        let observable = Observable<String>.of(urlChampion)
            .map { urlString -> URL in
                return URL(string: urlString)!
            }
            .map { url -> URLRequest in
                return URLRequest(url: url)
            }
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            .share(replay: 1)
        
        observable
            .filter { response, _ -> Bool in
                return 200..<300 ~= response.statusCode
            }
            .map { _, data -> [Champion] in
                var listChampions: [Champion] = []
                let dictionary = self.convertToDictionary(data: data)
                if let _listChampions = dictionary?["data"] as? [String: NSDictionary] {
                    for champion in _listChampions {
                        //                        let championName = champion.key
                        let championInfor = champion.value
                        if let newChampion = Champion(dictionary: championInfor) {
                            listChampions.append(newChampion)
                        }
                    }
                }
                return listChampions.sorted(by: { $0.name ?? "" < $1.name ?? ""})
            }
            .filter { objects in
                return !objects.isEmpty
            }
            .subscribe(onNext: { champions in
                DispatchQueue.main.async {
                    self.champions = champions
                    self.championsTableView.reloadData()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func convertToDictionary(data: Data) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

extension LOLChampionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return champions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LOLChampionsCell
        let item = champions[indexPath.row]
        cell.nameLabel.text = item.name
        cell.titleLabel.text = item.title
        let urlString = "https://nguyenht65.github.io/LOLResources/LoLResouces/lol/img/champion/\(item.image?.full ?? "")"
        cell.championImageView.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "lolLogo"))
        return cell
    }
    
}
