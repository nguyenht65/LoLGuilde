//
//  DominationView.swift
//  LoLGuilde
//
//  Created by Bang on 10/11/2021.
//

import UIKit
import DeviceKit

class DominationView: BaseView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var slot11View: EachRuneView!
    @IBOutlet weak var slot12View: EachRuneView!
    @IBOutlet weak var slot13View: EachRuneView!
    @IBOutlet weak var slot14View: EachRuneView!
    @IBOutlet weak var slot21View: EachRuneView!
    @IBOutlet weak var slot22View: EachRuneView!
    @IBOutlet weak var slot23View: EachRuneView!
    @IBOutlet weak var slot31View: EachRuneView!
    @IBOutlet weak var slot32View: EachRuneView!
    @IBOutlet weak var slot33View: EachRuneView!
    @IBOutlet weak var slot41View: EachRuneView!
    @IBOutlet weak var slot42View: EachRuneView!
    @IBOutlet weak var slot43View: EachRuneView!
    @IBOutlet weak var slot44View: EachRuneView!
    @IBOutlet weak var nameTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameBottomConstraint: NSLayoutConstraint!

    private var runeViews: [EachRuneView] {
        return [slot11View, slot12View, slot13View, slot14View, slot21View, slot22View, slot23View, slot31View, slot32View, slot33View, slot41View, slot42View, slot43View, slot44View]
    }

    private var rune: Rune!

    private lazy var runesDetailView: RunesDetailView = {
        let screenSize = self.layer.bounds.size
        let view = RunesDetailView(frame: CGRect(x: 0, y: 0, width: screenSize.width * 3 / 4, height: screenSize.height * 4 / 9))
        view.center = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func commonInit() {
        super.commonInit()
        setupAction()
        setDeviceConstraint()
    }

    private func setDeviceConstraint() {
        let device = Device.current
        switch device {
        case .simulator(.iPhoneSE):
            nameTopConstraint.constant = 20
            nameBottomConstraint.constant = 30
            break
        default:
            break
        }
    }

    func setupData(rune: Rune) {
        self.rune = rune
    }

    func setupUI(item: Rune) {
        nameLabel.text = item.name
        slot11View.setupUI(item: item, slotsIndex: 0, runeIndex: 0)
        slot12View.setupUI(item: item, slotsIndex: 0, runeIndex: 1)
        slot13View.setupUI(item: item, slotsIndex: 0, runeIndex: 2)
        slot14View.setupUI(item: item, slotsIndex: 0, runeIndex: 3)
        slot21View.setupUI(item: item, slotsIndex: 1, runeIndex: 0)
        slot22View.setupUI(item: item, slotsIndex: 1, runeIndex: 1)
        slot23View.setupUI(item: item, slotsIndex: 1, runeIndex: 2)
        slot31View.setupUI(item: item, slotsIndex: 2, runeIndex: 0)
        slot32View.setupUI(item: item, slotsIndex: 2, runeIndex: 1)
        slot33View.setupUI(item: item, slotsIndex: 2, runeIndex: 2)
        slot41View.setupUI(item: item, slotsIndex: 3, runeIndex: 0)
        slot42View.setupUI(item: item, slotsIndex: 3, runeIndex: 1)
        slot43View.setupUI(item: item, slotsIndex: 3, runeIndex: 2)
        slot44View.setupUI(item: item, slotsIndex: 3, runeIndex: 3)
    }
    
    func setupAction() {
        runeViews.forEach { rune in
            rune.imageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        }
    }

    @objc func buttonAction(sender: UIButton!) {
        runesDetailView.removeFromSuperview()
        let buttonTag: UIButton = sender
        switch buttonTag.tag {
        case 0:
            runesDetailView.setupData(item: rune, slotsIndex: 0, runeIndex: 0)
        case 1:
            runesDetailView.setupData(item: rune, slotsIndex: 0, runeIndex: 1)
        case 2:
            runesDetailView.setupData(item: rune, slotsIndex: 0, runeIndex: 2)
        case 3:
            runesDetailView.setupData(item: rune, slotsIndex: 0, runeIndex: 3)
        case 4:
            runesDetailView.setupData(item: rune, slotsIndex: 1, runeIndex: 0)
        case 5:
            runesDetailView.setupData(item: rune, slotsIndex: 1, runeIndex: 1)
        case 6:
            runesDetailView.setupData(item: rune, slotsIndex: 1, runeIndex: 2)
        case 7:
            runesDetailView.setupData(item: rune, slotsIndex: 2, runeIndex: 0)
        case 8:
            runesDetailView.setupData(item: rune, slotsIndex: 2, runeIndex: 1)
        case 9:
            runesDetailView.setupData(item: rune, slotsIndex: 2, runeIndex: 2)
        case 10:
            runesDetailView.setupData(item: rune, slotsIndex: 3, runeIndex: 0)
        case 11:
            runesDetailView.setupData(item: rune, slotsIndex: 3, runeIndex: 1)
        case 12:
            runesDetailView.setupData(item: rune, slotsIndex: 3, runeIndex: 2)
        case 13:
            runesDetailView.setupData(item: rune, slotsIndex: 3, runeIndex: 3)
        default:
            return
        }
        self.addSubview(runesDetailView)
    }
}
