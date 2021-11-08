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

    var champion: Champion!
    var _urlStringImage: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
//        let generalView = GeneralView()
//        generalView.translatesAutoresizingMaskIntoConstraints = false
        let generalView = GeneralView(frame: infoStackView.bounds)
        generalView.setupData(item: champion)
        infoStackView.addArrangedSubview(generalView)
    }

    override func setupUI() {
        title = "Champion Info"
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "textColor")]
        segmentedControl.setTitleTextAttributes(titleTextAttributes as [NSAttributedString.Key : Any], for: .normal)
        segmentedControl.setTitleTextAttributes(titleTextAttributes as [NSAttributedString.Key : Any], for: .selected)
    }

    override func setupData() {
        nameLabel.text = champion.name
        titleLabel.text = champion.title
        tag1Label.text = champion.tags?[0]
        if champion.tags?.count ?? 1 > 1 {
            tag2Label.text = champion.tags?[1]
        } else {
            tag2Label.text = ""
        }
        championImageView.sd_setImage(with: URL(string: _urlStringImage), placeholderImage: UIImage(named: "ic_tb1"))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func changeSegmentedControl(_ sender: UISegmentedControl) {
        for i in infoStackView.arrangedSubviews {
            i.removeFromSuperview()
        }
        var view = UIView()
        if sender.selectedSegmentIndex == 0 {
            view = GeneralView(frame: infoStackView.bounds)
            (view as? GeneralView)?.setupData(item: champion)
        } else if sender.selectedSegmentIndex == 1 {
            view = SkillsView(frame: infoStackView.bounds)
        } else if sender.selectedSegmentIndex == 2 {
            view = LoreView(frame: infoStackView.bounds)
            (view as? LoreView)?.setupData(item: champion)
        } else {
            view = SkinsView(frame: infoStackView.bounds)
        }
        infoStackView.addArrangedSubview(view)
    }
}
