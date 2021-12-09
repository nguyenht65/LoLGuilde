//
//  RuneTypeView.swift
//  LoLib
//
//  Created by Bang on 09/12/2021.
//

import UIKit
import DeviceKit

class RuneTypeView: BaseView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var slot1StackView: UIStackView!
    @IBOutlet weak var slot2StackView: UIStackView!
    @IBOutlet weak var slot3StackView: UIStackView!
    @IBOutlet weak var slot4StackView: UIStackView!
    @IBOutlet weak var slot1View: EachRuneView!
    @IBOutlet weak var slot2View: EachRuneView!
    @IBOutlet weak var slot3View: EachRuneView!
    @IBOutlet weak var slot4View: EachRuneView!
    @IBOutlet weak var nameTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameBottomConstraint: NSLayoutConstraint!

    private var buttonTags: [Int] = []
    private var tempIndex: Int = 0
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

    fileprivate func createSubView(_ item: Rune, _ stackView: UIStackView, _ slotView: EachRuneView, _ slotIndex: Int) {
        for _ in 0 ..< item.slots[slotIndex].runes.count - 1 {
            stackView.addArrangedSubview(EachRuneView(frame: slotView.bounds))
        }
        stackView.arrangedSubviews.enumerated().forEach { (index, view) in
            guard let view = view as? EachRuneView else { return }
            view.setupUI(item: item, slotsIndex: slotIndex, runeIndex: index)
            tempIndex = index
            for tag in buttonTags {
                if tag == tempIndex {
                    tempIndex = tempIndex + 1
                }
            }
            view.imageButton.tag = tempIndex
            buttonTags.append(tempIndex)
            view.imageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        }
        if stackView.arrangedSubviews.count < 4 {
            tempIndex = tempIndex + 1
            buttonTags.append(tempIndex)
        }
    }

    func setupUI(item: Rune) {
        nameLabel.text = item.name
        createSubView(item, slot1StackView, slot1View, 0)
        createSubView(item, slot2StackView, slot2View, 1)
        createSubView(item, slot3StackView, slot3View, 2)
        createSubView(item, slot4StackView, slot4View, 3)
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
            runesDetailView.setupData(item: rune, slotsIndex: 1, runeIndex: 3)
        case 8:
            runesDetailView.setupData(item: rune, slotsIndex: 2, runeIndex: 0)
        case 9:
            runesDetailView.setupData(item: rune, slotsIndex: 2, runeIndex: 1)
        case 10:
            runesDetailView.setupData(item: rune, slotsIndex: 2, runeIndex: 2)
        case 11:
            runesDetailView.setupData(item: rune, slotsIndex: 2, runeIndex: 3)
        case 12:
            runesDetailView.setupData(item: rune, slotsIndex: 3, runeIndex: 0)
        case 13:
            runesDetailView.setupData(item: rune, slotsIndex: 3, runeIndex: 1)
        case 14:
            runesDetailView.setupData(item: rune, slotsIndex: 3, runeIndex: 2)
        case 15:
            runesDetailView.setupData(item: rune, slotsIndex: 3, runeIndex: 3)
        default:
            return
        }
        self.addSubview(runesDetailView)
    }
}
