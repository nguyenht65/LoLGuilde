//
//  RuneTypeView.swift
//  LoLib
//
//  Created by Bang on 09/12/2021.
//

import UIKit

class RuneTypeView: BaseView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var runesStackView: UIStackView!
    @IBOutlet weak var nameTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameBottomConstraint: NSLayoutConstraint!

    private var rune: Rune

    private lazy var screenSize: CGRect = UIScreen.main.bounds

    private lazy var runesDetailView: RunesDetailView = {
        let view = RunesDetailView(frame: CGRect(x: 0, y: 0, width: screenSize.width * 3 / 4, height: screenSize.height * 4 / 9))
        view.center = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
        return view
    }()

    init(frame: CGRect, rune: Rune) {
        self.rune = rune
        super.init(frame: frame)
    }

    init?(coder: NSCoder, rune: Rune) {
        self.rune = rune
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        fatalError("Error")
    }

    required init?(coder: NSCoder) {
        fatalError("Error")
    }

    override func commonInit() {
        super.commonInit()
        setupUI()
    }

    private func setupUI() {
        setDeviceConstraint()
        nameLabel.text = rune.name
        setupRuneView()
    }

    private func setupRuneView() {
        let screenWidth = screenSize.width
        for slotIndex in 0 ..< rune.slots.count {
            let stackView = UIStackView()
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.spacing = 30
            stackView.translatesAutoresizingMaskIntoConstraints = false
            let runeHeightConstant = slotIndex == 0 ? (screenWidth / 6) : (screenWidth / 7)
            for runeIndex in 0 ..< rune.slots[slotIndex].runes.count {
                let runeFrame = CGRect(x: 0, y: 0, width: runeHeightConstant, height: runeHeightConstant)
                let runeView = EachRuneView(frame: runeFrame)
                runeView.heightAnchor.constraint(equalToConstant: runeHeightConstant).isActive = true
                runeView.widthAnchor.constraint(equalToConstant: runeHeightConstant).isActive = true
                runeView.setupUI(item: rune, slotsIndex: slotIndex, runeIndex: runeIndex)
                runeView.onPress = { [weak self] in
                    guard let self = self else { return }
                    self.runesDetailView.removeFromSuperview()
                    self.runesDetailView.setupData(item: self.rune, slotsIndex: slotIndex, runeIndex: runeIndex)
                    self.addSubview(self.runesDetailView)
                }
                stackView.addArrangedSubview(runeView)
            }
            runesStackView.addArrangedSubview(stackView)
        }
    }

    private func setDeviceConstraint() {
        if DeviceHelper().isSmallDevice() {
            nameTopConstraint.constant = 20
            nameBottomConstraint.constant = 30
        }
    }

    func closeDetailView() {
        runesDetailView.removeFromSuperview()
    }
}

