//
//  SkinsView.swift
//  LoLGuilde
//
//  Created by Bang on 10/11/2021.
//

import UIKit

class SkinsView: BaseView {

    @IBOutlet weak var skinsTableView: UITableView!

    private var champion: Champion!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func commonInit() {
        super.commonInit()
        let nib = UINib(nibName: SkinsCell.className, bundle: .main)
        skinsTableView.register(nib, forCellReuseIdentifier: "cell")
        skinsTableView.delegate = self
        skinsTableView.dataSource = self
    }

    func getChampion(champion: Champion) {
        self.champion = champion
    }
}

extension SkinsView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return champion.skins?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SkinsCell
        cell.setupData(item: champion, index: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
}
