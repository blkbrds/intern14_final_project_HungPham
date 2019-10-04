import Foundation

final class SearchCellModel {

    var title: String
    var description: String
    var publishedAt: String
    var imageURL: String

    init(searchedVideo: Channel) {
        self.title = searchedVideo.title
        self.description = searchedVideo.descriptionVideo
        self.publishedAt = searchedVideo.publishedAt
        self.imageURL = searchedVideo.imageURL
    }
}
