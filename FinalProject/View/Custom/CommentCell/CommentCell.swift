import UIKit

final class CommentCell: UITableViewCell {

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

    @IBOutlet private weak var authorImageView: UIImageView!
    @IBOutlet private weak var authorName: UILabel!
    @IBOutlet private weak var authorText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        authorImageView.layer.cornerRadius = 30
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
