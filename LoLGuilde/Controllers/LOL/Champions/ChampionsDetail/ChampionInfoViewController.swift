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
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var championImageView: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var _name: String = ""
    var _title: String = ""
    var _urlStringImage: String = ""
    var _tag: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        title = "Champion Info"
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "textColor")]
        segmentedControl.setTitleTextAttributes(titleTextAttributes as [NSAttributedString.Key : Any], for: .normal)
        segmentedControl.setTitleTextAttributes(titleTextAttributes as [NSAttributedString.Key : Any], for: .selected)
    }
    
    override func setupData() {
        nameLabel.text = _name
        titleLabel.text = _title
        for t in _tag {
            tagLabel.text?.append(contentsOf: t + " ")
        }
        championImageView.sd_setImage(with: URL(string: _urlStringImage), placeholderImage: UIImage(named: "ic_tb1"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}
