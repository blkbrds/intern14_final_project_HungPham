import UIKit

final class ChannelVideosCell: UICollectionViewCell {

    @IBOutlet private weak var videoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    @IBAction private func playButton(_ sender: Any) {
        print("button Did Click!")
    }

    var viewModel: ChannelVideosCellModel? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        videoImageView.sd_setImage(with: URL(string: viewModel.imageURL))
    }
}
