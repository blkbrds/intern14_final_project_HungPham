import UIKit

protocol CustomInfoWindowDelegate: class {
    func tapDetail(_ infoView: CustomInfoWindow, sender: UIButton)
}

class CustomInfoWindow: UIView {

    weak var delegate: CustomInfoWindowDelegate?
    var view: UIView!

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var placeSubTitle: UILabel!
    @IBOutlet weak var tapButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func loadView() -> CustomInfoWindow {
        guard let customInfoView = Bundle.main.loadNibNamed("CustomInfoWindow", owner: self, options: nil)?[0] as? CustomInfoWindow else { return CustomInfoWindow() }
        return customInfoView
    }

    @IBAction func tapButton(_ sender: UIButton) {
        print("button Did Click !")
        delegate?.tapDetail(self, sender: sender)
    }
}
