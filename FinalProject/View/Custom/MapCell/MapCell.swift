import UIKit

protocol MapCellDelegate: class {
    func tapRoute(_ mapCellView: MapCell, sender: UIButton)
}

final class MapCell: UICollectionViewCell {

    weak var delegate: MapCellDelegate?

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var placeSubTitle: UILabel!
    @IBOutlet weak var placeDirection: UIButton!
    @IBOutlet weak var placeCall: UIButton!
    @IBOutlet weak var placeShare: UIButton!

    @IBAction func directionRoute(_ sender: UIButton) {
        delegate?.tapRoute(self, sender: sender)
    }
}
