import Foundation
import Realm
import RealmSwift

final class DetailViewModel {

    var myComment: [Comment] = []

    func getDataComment(completion: @escaping (Bool) -> Void) {
        ApiManager.Snippet.getCommentData(videoId: id) { (result) in
            switch result {
            case .success(let commentResult):
                print(self.video)
                self.myComment.append(contentsOf: commentResult.myComment)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }

    var video: Trending

    var id: String {
        return video.id
    }

    var title: String {
        return video.title
    }

    var duration: String {
        return video.duration
    }

    var viewCount: String {
        return video.viewCount
    }

    var likeCount: String {
        return video.likeCount
    }

    var dislikeCount: String {
        return video.dislikeCount
    }

    var publishedAt: String {
        return video.publishedAt
    }

    var imageURL: String {
        return video.imageURL
    }

    var descriptionDetail: String {
        return video.descriptionDetail
    }

    init(video: Trending = Trending()) {
        self.video = video
    }
}
