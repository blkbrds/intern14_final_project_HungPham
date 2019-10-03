import UIKit

final class CommentCell: UITableViewCell {

    @IBOutlet private weak var authorImageView: UIImageView!
    @IBOutlet private weak var authorName: UILabel!
    @IBOutlet private weak var authorText: UILabel!

    var viewModel: CommentCellModel? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        guard let viewModel = viewModel else { return }
        authorName.text = viewModel.authorDisplayName
        authorText.text = viewModel.textOriginal
        authorImageView.sd_setImage(with: URL(string: viewModel.authorProfileImageUrl))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        authorImageView.layer.cornerRadius = 30
    }
}
