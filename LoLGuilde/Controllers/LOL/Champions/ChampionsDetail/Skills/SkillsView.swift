//
//  SkillsView.swift
//  LoLGuilde
//
//  Created by Bang on 05/11/2021.
//

import UIKit

class SkillsView: BaseView {

    @IBOutlet weak var skillsTableView: UITableView!
    private var champion: Champion!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func commonInit() {
        super.commonInit()
        let nib1 = UINib(nibName: PassiveCell.className, bundle: .main)
        let nib2 = UINib(nibName: SkillsCell.className, bundle: .main)
        skillsTableView.register(nib1, forCellReuseIdentifier: "passiveCell")
        skillsTableView.register(nib2, forCellReuseIdentifier: "skillsCell")
        skillsTableView.delegate = self
        skillsTableView.dataSource = self
    }
    
    func getChampion(champion: Champion) {
        self.champion = champion
    }
}

extension SkillsView: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.deselectRow(at: indexPath, animated: true)
        if  indexPath.row == 0 {
            let cell = skillsTableView.dequeueReusableCell(withIdentifier: "passiveCell", for: indexPath) as! PassiveCell
            cell.setupData(item: champion)
            return cell
        } else {
            let cell = skillsTableView.dequeueReusableCell(withIdentifier: "skillsCell", for: indexPath) as! SkillsCell
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
