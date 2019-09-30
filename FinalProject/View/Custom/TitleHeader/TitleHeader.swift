//
//  TitleHeader.swift
//  FinalProject
//
//  Created by PCI0010 on 9/30/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

protocol TitleHeaderViewDelegate: class {
    func tapMore(_ view: TitleHeader, sender: UIButton)
}

final class TitleHeader: UICollectionReusableView {

    @IBOutlet weak var titleHeaderLabel: UILabel!

    weak var delegate: TitleHeaderViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction private func moreButton(_ sender: UIButton) {
        delegate?.tapMore(self, sender: sender)
    }
}
