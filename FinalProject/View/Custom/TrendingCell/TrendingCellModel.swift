import Foundation
import UIKit

final class TrendingCellViewModel {

    var title: String
    var duration: String
    var imageURL: String

    init(myTrending: Trending) {
        self.title = myTrending.title
        self.duration = myTrending.duration
        self.imageURL = myTrending.imageURL
    }
}
