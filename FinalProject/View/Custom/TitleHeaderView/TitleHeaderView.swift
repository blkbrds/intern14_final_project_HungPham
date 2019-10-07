import UIKit

protocol TitleHeaderViewDelegate: class {
    func tapMoreTrending(_ titleHeaderView: TitleHeaderView, sender: UIButton)
    func tapMoreChannel(_ titleHeaderView: TitleHeaderView, sender: UIButton)
}

final class TitleHeaderView: UICollectionReusableView {

    var checkTitle = true

    @IBOutlet weak var titleHeaderLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!

    weak var delegate: TitleHeaderViewDelegate?

    @IBAction private func moreButton(_ sender: UIButton) {
        if checkTitle {
            delegate?.tapMoreTrending(self, sender: sender)
        } else {
            delegate?.tapMoreChannel(self, sender: sender)
        }
    }
}
