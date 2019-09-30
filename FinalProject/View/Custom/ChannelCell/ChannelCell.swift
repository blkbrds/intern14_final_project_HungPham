//
//  ChannelCell.swift
//  FinalProject
//
//  Created by PCI0010 on 9/30/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

final class ChannelCell: UICollectionViewCell {

    var viewmodel: ChannelCellModel? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        guard let viewmodel = viewmodel else { return }
        titleLabel.text = viewmodel.title
        videoImage.sd_setImage(with: URL(string: viewmodel.imageURL))
    }

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var videoImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
