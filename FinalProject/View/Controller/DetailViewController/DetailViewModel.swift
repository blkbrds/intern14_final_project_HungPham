import Foundation
import Realm
import RealmSwift

final class DetailViewModel {

    var myComments: [Comment] = []
    var notificationToken: NotificationToken?

    func getDataComment(completion: @escaping (Bool) -> Void) {
        ApiManager.Snippet.getCommentData(videoId: id) { (result) in
            switch result {
            case .success(let commentResult):
                print(self.video)
                self.myComments.append(contentsOf: commentResult.myComments)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }

    func checkId(completion: (Bool) -> Void) {
        let videoIdFilter = NSPredicate(format: "id = '\(self.video.id)'")
        guard let videoResult = RealmManager.shared.fetchObjects(Trending.self, filter: videoIdFilter) else {
            completion(false)
            return }
        let videos = [Trending](videoResult)
        if videos.count == 0 {
            print("🔴 Chua co FAVORITE")
            completion(false)
        } else {
            print("🔵 Da co FAVORITE")
            completion(true)
        }
    }

    func checkId() -> Bool {
        let videoIdFilter = NSPredicate(format: "id = '\(self.video.id)'")
        guard let videoResult = RealmManager.shared.fetchObjects(Trending.self, filter: videoIdFilter) else {
            return false }
        let videos = [Trending](videoResult)
        if videos.count == 0 {
            return false
        } else {
            return true
        }
    }

    func saveRealm(completion: @escaping (_ done: Bool, _ isAdd: Bool) -> Void) {
        if checkId() {
            //REMOVE FAVORITE
            let videoIdFilter = NSPredicate(format: "id = '\(self.video.id)'")
            guard let videoResult = RealmManager.shared.fetchObjects(Trending.self, filter: videoIdFilter) else {
                completion(false, false)
                return
            }
            if let video = [Trending](videoResult).first {
                RealmManager.shared.delete(object: video) { (result) in
                    switch result {
                    case .success:
                        print("REMOVE DONE")
                        completion(true, false)
                    case .failure(let error):
                        print("REMOVE ERROR: \(error.localizedDescription)")
                        completion(false, false)
                    }
                }
            } else {
                completion(false, false)
            }
        } else {
            //ADD FAVORITE
            let copyVideo = Trending(value: self.video)
            RealmManager.shared.add(object: copyVideo) { (result) in
                switch result {
                case .success:
                    print("ADD DONE")
                    completion(true, true)
                case .failure(let error):
                    print("ADD ERROR: \(error.localizedDescription)")
                    completion(false, true)
                }
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

extension DetailViewModel {

    func numberOfItemsTrending(in section: Int) -> Int {
        return myComments.count
    }

    func getComment(with indexPath: IndexPath) -> Comment {
        return myComments[indexPath.row]
    }
}
