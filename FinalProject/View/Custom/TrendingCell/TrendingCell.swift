import SDWebImage
import UIKit

class TrendingCell: UICollectionViewCell {

    var viewmodel: TrendingCellViewModel? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        guard let viewmodel = viewmodel else { return }
        titleLabel.text = viewmodel.title
        timeLabel.text = viewmodel.duration.replacingOccurrences(of: "PT", with: "").replacingOccurrences(of: "H", with:":").replacingOccurrences(of: "M", with: ":").replacingOccurrences(of: "S", with: "")
        videoImage.sd_setImage(with: URL(string: viewmodel.imageURL))
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var videoImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func playButton(_ sender: Any) {
        print("button Did Click !")
    }

}
