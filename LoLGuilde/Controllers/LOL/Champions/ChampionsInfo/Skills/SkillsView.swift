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
        skillsTableView.register(nib1, forCellReuseIdentifier: PassiveCell.className)
        skillsTableView.register(nib2, forCellReuseIdentifier: SkillsCell.className)
        skillsTableView.delegate = self
        skillsTableView.dataSource = self
    }

    func getChampion(champion: Champion) {
        self.champion = champion
    }
}

extension SkillsView: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return champion.spells.count 
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            guard let cell = skillsTableView.dequeueReusableCell(withIdentifier: PassiveCell.className, for: indexPath) as? PassiveCell else {
                fatalError("dequeue cell error")
            }
            cell.setupData(item: champion)
            return cell
        } else {
            guard let cell = skillsTableView.dequeueReusableCell(withIdentifier: SkillsCell.className, for: indexPath) as? SkillsCell else {
                fatalError("dequeue cell error")
            }
            cell.setupData(item: champion, index: indexPath.row - 1)
            return cell
        }
    }
    
    
}
