//
//  TitleHeader.swift
//  FinalProject
//
//  Created by PCI0010 on 9/30/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

protocol TitleHeaderViewDelegate: class {
    func tapMoreTrending(_ titleHeaderView: TitleHeaderView, sender: UIButton)
    func tapMoreChannel(_ titleHeaderView: TitleHeaderView, sender: UIButton)
}

final class TitleHeaderView: UICollectionReusableView {

    var isClickedTitle = true

    @IBOutlet weak var titleHeaderLabel: UILabel!

    weak var delegate: TitleHeaderViewDelegate?

    @IBAction private func moreButton(_ sender: UIButton) {
        if isClickedTitle {
            delegate?.tapMoreTrending(self, sender: sender)
        } else {
            delegate?.tapMoreChannel(self, sender: sender)
        }
    }
}
