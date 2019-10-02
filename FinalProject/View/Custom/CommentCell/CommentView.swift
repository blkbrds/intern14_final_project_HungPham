//
//  CommentView.swift
//  FinalProject
//
//  Created by PCI0010 on 10/2/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

final class CommentCell: UITableViewCell {

    var viewModel: CommentViewModel {
        didSet {
        }
    }

    @IBOutlet private weak var authorImageView: UIImageView!
    @IBOutlet private weak var authorName: UILabel!
    @IBOutlet private weak var authorText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
