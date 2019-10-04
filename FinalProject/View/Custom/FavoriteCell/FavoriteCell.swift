//
//  FavoriteCell.swift
//  FinalProject
//
//  Created by PCI0010 on 10/2/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

final class FavoriteCell: UITableViewCell {

    @IBOutlet private weak var videoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var likeCountLabel: UILabel!
    @IBOutlet private weak var dislikeCountLabel: UILabel!
    @IBOutlet private weak var viewCountLabel: UILabel!
    @IBOutlet private weak var publicDateLabel: UILabel!
    @IBOutlet private weak var timeDurationLabel: UILabel!

    var viewModel: FavoriteCellModel? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        likeCountLabel.text = viewModel.likeCount + " Like"
        dislikeCountLabel.text = viewModel.dislikeCount + " Dislike"
        viewCountLabel.text = viewModel.viewCount + " Views"
        publicDateLabel.text = viewModel.publishedAt
        timeDurationLabel.text = viewModel.duration.replacingOccurrences(of: "PT", with: "")
            .replacingOccurrences(of: "H", with: ":")
            .replacingOccurrences(of: "M", with: ":")
            .replacingOccurrences(of: "S", with: "")
        videoImageView.sd_setImage(with: URL(string: viewModel.imageURL))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
