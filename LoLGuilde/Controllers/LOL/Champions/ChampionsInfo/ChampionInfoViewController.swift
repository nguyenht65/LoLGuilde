//
//  ChampionInfoViewController.swift
//  LoLGuilde
//
//  Created by Bang on 01/11/2021.
//

import UIKit

class ChampionInfoViewController: BaseViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tag1Label: UILabel!
    @IBOutlet weak var tag2Label: UILabel!
    @IBOutlet weak var championImageView: UIImageView!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    private var champion: Champion!

    private lazy var generalView: GeneralView = {
        let view = GeneralView(frame: infoStackView.bounds)
        view.setupData(item: champion)
        return view
    }()
    private lazy var skillsView: SkillsView = {
        let view = SkillsView(frame: infoStackView.bounds)
        view.getChampion(champion: champion)
        return view
    }()
    private lazy var loreView: LoreView = {
        let view = LoreView(frame: infoStackView.bounds)
        view.setupData(item: champion)
        return view
    }()
    private lazy var skinsView: SkinsView = {
        let view = SkinsView(frame: infoStackView.bounds)
        view.getChampion(champion: champion)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        let generalView = GeneralView()
//        generalView.translatesAutoresizingMaskIntoConstraints = false
        let generalView = generalView
        infoStackView.addArrangedSubview(generalView)
    }

    func getChampion(champion: Champion) {
        self.champion = champion
    }

    override func setupUI() {
        title = "Champion Info"
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "textColor")]
        segmentedControl.setTitleTextAttributes(titleTextAttributes as [NSAttributedString.Key: Any], for: .normal)
        segmentedControl.setTitleTextAttributes(titleTextAttributes as [NSAttributedString.Key: Any], for: .selected)
    }

    override func setupData() {
        nameLabel.text = champion.name
        titleLabel.text = champion.title
        tag1Label.text = champion.tags[0].rawValue
        if champion.tags.count > 1 {
            tag2Label.text = champion.tags[1].rawValue
        } else {
            tag2Label.text = ""
        }
        championImageView.sd_setImage(with: URL(string: champion.urlImage), placeholderImage: UIImage(named: champion.placeholderImage))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func changeSegmentedControl(_ sender: UISegmentedControl) {
        for view in infoStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        var view = UIView()
        switch sender.selectedSegmentIndex {
        case 0:
            view = generalView
        case 1:
            view = skillsView
        case 2:
            view = loreView
        case 3:
            view = skinsView
        default:
            return
        }
        infoStackView.addArrangedSubview(view)
    }
}
