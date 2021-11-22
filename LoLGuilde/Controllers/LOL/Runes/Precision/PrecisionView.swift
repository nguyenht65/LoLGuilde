//
//  PrecisionView.swift
//  LoLGuilde
//
//  Created by Bang on 10/11/2021.
//

import UIKit

class PrecisionView: BaseView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var slot1_r1View: EachRuneView!
    @IBOutlet weak var slot1_r2View: EachRuneView!
    @IBOutlet weak var slot1_r3View: EachRuneView!
    @IBOutlet weak var slot1_r4View: EachRuneView!
    @IBOutlet weak var slot2_r1View: EachRuneView!
    @IBOutlet weak var slot2_r2View: EachRuneView!
    @IBOutlet weak var slot2_r3View: EachRuneView!
    @IBOutlet weak var slot3_r1View: EachRuneView!
    @IBOutlet weak var slot3_r2View: EachRuneView!
    @IBOutlet weak var slot3_r3View: EachRuneView!
    @IBOutlet weak var slot4_r1View: EachRuneView!
    @IBOutlet weak var slot4_r2View: EachRuneView!
    @IBOutlet weak var slot4_r3View: EachRuneView!

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
    }

    func setupData(rune: Rune) {
        self.rune = rune
    }

    func setupUI(item: Rune) {
        nameLabel.text = item.name
        slot1_r1View.setupUI(item: item, slotsIndex: 0, runeIndex: 0)
        slot1_r2View.setupUI(item: item, slotsIndex: 0, runeIndex: 1)
        slot1_r3View.setupUI(item: item, slotsIndex: 0, runeIndex: 2)
        slot1_r4View.setupUI(item: item, slotsIndex: 0, runeIndex: 3)
        slot2_r1View.setupUI(item: item, slotsIndex: 1, runeIndex: 0)
        slot2_r2View.setupUI(item: item, slotsIndex: 1, runeIndex: 1)
        slot2_r3View.setupUI(item: item, slotsIndex: 1, runeIndex: 2)
        slot3_r1View.setupUI(item: item, slotsIndex: 2, runeIndex: 0)
        slot3_r2View.setupUI(item: item, slotsIndex: 2, runeIndex: 1)
        slot3_r3View.setupUI(item: item, slotsIndex: 2, runeIndex: 2)
        slot4_r1View.setupUI(item: item, slotsIndex: 3, runeIndex: 0)
        slot4_r2View.setupUI(item: item, slotsIndex: 3, runeIndex: 1)
        slot4_r3View.setupUI(item: item, slotsIndex: 3, runeIndex: 2)
    }

    func setupAction() {
        slot1_r1View.imageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        slot1_r2View.imageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        slot1_r3View.imageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        slot1_r4View.imageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        slot2_r1View.imageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        slot2_r2View.imageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        slot2_r3View.imageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        slot3_r1View.imageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        slot3_r2View.imageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        slot3_r3View.imageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        slot4_r1View.imageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        slot4_r2View.imageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        slot4_r3View.imageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
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
        default:
            return
        }
        self.addSubview(runesDetailView)
    }
    
}

