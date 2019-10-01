//
//  TitleHeader.swift
//  FinalProject
//
//  Created by PCI0010 on 9/30/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

protocol TitleHeaderViewDelegate: class {
    func tapMore(_ titleHeaderView: TitleHeaderView, sender: UIButton)
}

final class TitleHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleHeaderLabel: UILabel!

    weak var delegate: TitleHeaderViewDelegate?

    @IBAction private func moreButton(_ sender: UIButton) {
        delegate?.tapMore(self, sender: sender)
    }
}
