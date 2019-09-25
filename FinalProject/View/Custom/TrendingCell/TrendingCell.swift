//
//  TrendingCell.swift
//  FinalProject
//
//  Created by PCI0010 on 9/25/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

class TrendingCell: UICollectionViewCell {

    var viewmodel: TrendingCellViewModel? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        self.titleLabel.text = viewmodel?.title
        self.timeLabel.text = viewmodel?.duration.replacingOccurrences(of: "PT", with: "").replacingOccurrences(of: "H", with:":").replacingOccurrences(of: "M", with: ":").replacingOccurrences(of: "S", with: "")
        self.videoImage.image = viewmodel?.videoImage
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var videoImage: UIImageView!

    @IBAction func playButton(_ sender: Any) {
        print("button Did Click !")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
