import SDWebImage
import UIKit

class TrendingCell: UICollectionViewCell {

    var viewModel: TrendingCellViewModel? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        timeLabel.text = viewModel.duration.replacingOccurrences(of: "PT", with: "")
            .replacingOccurrences(of: "H", with: ":")
            .replacingOccurrences(of: "M", with: ":")
            .replacingOccurrences(of: "S", with: "")
        videoImage.sd_setImage(with: URL(string: viewModel.imageURL))
    }

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var videoImage: UIImageView!

}
