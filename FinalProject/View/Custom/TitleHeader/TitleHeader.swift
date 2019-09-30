//
//  TitleHeader.swift
//  FinalProject
//
//  Created by PCI0010 on 9/30/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

final class TitleHeader: UICollectionReusableView {

    @IBOutlet weak var titleHeaderLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction private func moreButton(_ sender: Any) {
        print("button Did Click !")
    }
}
