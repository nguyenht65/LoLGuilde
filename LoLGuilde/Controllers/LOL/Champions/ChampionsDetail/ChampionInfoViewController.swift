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
    @IBOutlet var infoView: UIView!
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
        tag1Label.text = _tag[0]
        if _tag.count > 1 {
            tag2Label.text = _tag[1]
        } else {
            tag2Label.text = ""
        }
        championImageView.sd_setImage(with: URL(string: _urlStringImage), placeholderImage: UIImage(named: "ic_tb1"))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func changeSegmentedControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 2 {
            infoView = GeneralView()
        }
        print(sender.selectedSegmentIndex)
    }
}
