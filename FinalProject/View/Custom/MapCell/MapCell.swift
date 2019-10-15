import UIKit

final class MapCell: UICollectionViewCell {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var placeSubTitle: UILabel!
    @IBOutlet weak var placeDirection: UIButton!
    @IBOutlet weak var placeCall: UIButton!
    @IBOutlet weak var placeShare: UIButton!

    @IBAction func directionRoute(_ sender: UIButton) {
        print("Tapped !")
    }
}
