import Foundation

final class SearchCellModel {

    var title: String
    var description: String
    var publishedAt: String
    var imageURL: String

    init(mySearch: Channel) {
        self.title = mySearch.title
        self.description = mySearch.description
        self.publishedAt = mySearch.publishedAt
        self.imageURL = mySearch.imageURL
    }
}
