//
//  TitleHeader.swift
//  FinalProject
//
//  Created by PCI0010 on 9/25/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

class TitleHeader: UICollectionReusableView {

    @IBOutlet weak var titleHeaderLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func moreButton(_ sender: UIButton) {
        print("button Did Click !")
    }
}
