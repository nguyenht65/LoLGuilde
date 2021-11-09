//
//  UITableViewExtentions.swift
//  LoLGuilde
//
//  Created by Bang on 09/11/2021.
//

import UIKit

final class ContentSizedTableView: UITableView {

    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
