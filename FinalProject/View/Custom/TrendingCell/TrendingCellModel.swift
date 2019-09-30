import Foundation
import UIKit

final class TrendingCellViewModel {

    var title: String
    var duration: String
    var videoImage: UIImage?
    var imageURL: String

    init(myTrending: Trending) {
        self.title = myTrending.title
        self.duration = myTrending.duration
        self.videoImage = myTrending.videoImage
        self.imageURL = myTrending.imageURL
    }
}
