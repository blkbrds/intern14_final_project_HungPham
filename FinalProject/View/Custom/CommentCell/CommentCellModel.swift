import Foundation

final class CommentCellModel {

    var authorDisplayName: String
    var authorProfileImageUrl: String
    var textOriginal: String

    init(myVideo: Comment) {
        self.authorDisplayName = myVideo.authorDisplayName
        self.textOriginal = myVideo.textOriginal
        self.authorProfileImageUrl = myVideo.authorProfileImageUrl
    }
}
