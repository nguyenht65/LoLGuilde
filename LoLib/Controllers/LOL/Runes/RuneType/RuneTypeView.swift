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
    private var maxNumberOfRune: Int

    private lazy var runesDetailView: RunesDetailView = {
        let layer = self.layer.bounds.size
        let view = RunesDetailView(frame: CGRect(x: 0, y: 0, width: layer.width * 3 / 4, height: layer.height * 4 / 9))
        view.center = CGPoint(x: layer.width / 2, y: layer.height / 2)
        return view
    }()

    init(frame: CGRect, rune: Rune, maxNumberOfRune: Int) {
        self.rune = rune
        self.maxNumberOfRune = maxNumberOfRune
        super.init(frame: frame)
    }

    init?(coder: NSCoder, rune: Rune, maxNumberOfRune: Int) {
        self.rune = rune
        self.maxNumberOfRune = maxNumberOfRune
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
        nameLabel.text = rune.name
        runesStackView.spacing = screenHeight / 22
        nameTopConstraint.constant = screenHeight / 18
        nameBottomConstraint.constant = screenHeight / 15
        setupRuneView()
    }

    private func setupRuneView() {
        for slotIndex in 0 ..< rune.slots.count {
            let runeHeightConstant = slotIndex == 0 ? (screenWidth / 6) : (screenWidth / 7)
            let numberOfRuneInSlot = rune.slots[slotIndex].runes.count
            if numberOfRuneInSlot > maxNumberOfRune {
                let verticalStackView = getVerticleStackView()
                let numberOfRowDouble = ceil(Double(numberOfRuneInSlot) / Double(maxNumberOfRune))
                let numberOfRowInt = Int(numberOfRowDouble)
                for row in 0 ..< numberOfRowInt {
                    let horizontalStackView = getHorizontalStackView()
                    for runeIndex in 0 ..< maxNumberOfRune {
                        if row * maxNumberOfRune + runeIndex >= numberOfRuneInSlot {
                            break
                        }
                        createRunes(runeHeightConstant, slotIndex, row * maxNumberOfRune + runeIndex, horizontalStackView)
                    }
                    verticalStackView.addArrangedSubview(horizontalStackView)
                }
                runesStackView.addArrangedSubview(verticalStackView)
            } else {
                let horizontalStackView = getHorizontalStackView()
                for runeIndex in 0 ..< numberOfRuneInSlot {
                    createRunes(runeHeightConstant, slotIndex, runeIndex, horizontalStackView)
                }
                runesStackView.addArrangedSubview(horizontalStackView)
            }
        }
    }

    private func getHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = screenHeight / 29
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func getVerticleStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = screenHeight / 22
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    private func createRunes(_ runeHeightConstant: CGFloat, _ slotIndex: Int, _ runeIndex: Int, _ stackView: UIStackView) {
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

    func closeDetailView() {
        runesDetailView.removeFromSuperview()
    }
}

