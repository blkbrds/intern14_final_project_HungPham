//
//  ChannelCell.swift
//  FinalProject
//
//  Created by PCI0010 on 9/30/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

final class ChannelCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var videoImage: UIImageView!

    var viewModel: ChannelCellModel? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        videoImage.sd_setImage(with: URL(string: viewModel.imageURL))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
