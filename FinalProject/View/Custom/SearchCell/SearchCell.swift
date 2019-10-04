import UIKit

final class SearchCell: UITableViewCell {

    @IBOutlet private weak var videoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var publicdateLabel: UILabel!

    var viewModel: SearchCellModel? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        publicdateLabel.text = viewModel.publishedAt
        videoImageView.sd_setImage(with: URL(string: viewModel.imageURL))
    }
}
