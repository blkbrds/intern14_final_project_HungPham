import Foundation

final class FavoriteCellModel {

    var title: String
    var imageURL: String
    var duration: String
    var likeCount: String
    var dislikeCount: String
    var viewCount: String
    var publishedAt: String

    init(myTrending: Trending) {
        self.title = myTrending.title
        self.imageURL = myTrending.imageURL
        self.duration = myTrending.duration
        self.likeCount = myTrending.likeCount
        self.dislikeCount = myTrending.dislikeCount
        self.viewCount = myTrending.viewCount
        self.publishedAt = myTrending.publishedAt
    }
}
