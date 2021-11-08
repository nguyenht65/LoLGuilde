//
//  EachStatusView.swift
//  LoLGuilde
//
//  Created by Bang on 08/11/2021.
//

import UIKit

@IBDesignable
class EachStatusView: BaseView {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusValueLabel: UILabel!

    private var _status: String = ""
    private var _textColor: UIColor = UIColor(named: "textColor")!

    @IBInspectable
    var status: String {
        set (newValue) {
            _status = newValue
            statusLabel.text = _status
        } get {
            return _status
        }
    }

    @IBInspectable
    var textColor: UIColor {
        set (newValue) {
            _textColor = newValue
            statusLabel.textColor = _textColor
        } get {
            return _textColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func commonInit() {
        let bundle = Bundle.init(for: EachStatusView.self)
        guard let viewToAdd = bundle.loadNibNamed(EachStatusView.className, owner: self, options: nil), let contentView = viewToAdd.first as? UIView else {
            return
        }
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
