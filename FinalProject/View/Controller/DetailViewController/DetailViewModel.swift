import Foundation
import Realm
import RealmSwift

final class DetailViewModel {

    var video: Trending
    var myComments: [Comment] = []
    var notificationToken: NotificationToken?

    func getDataComment(completion: @escaping (Bool) -> Void) {
        ApiManager.Snippet.getCommentData(videoId: video.id) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let commentResult):
                this.myComments.append(contentsOf: commentResult.myComments)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }

    func checkIdFavorite(completion: (Bool) -> Void) {
        let videoIdFilter = NSPredicate(format: "id = '\(self.video.id)'")
        guard let videoResult = RealmManager.shared.fetchObjects(Trending.self, filter: videoIdFilter) else {
            completion(false)
            return }
        let videos = [Trending](videoResult)
        if videos.count == 0 {
            print("🔵 Not Exist in FAVORITE")
            completion(false)
        } else {
            print("🔴 Exist in FAVORITE")
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
            // REMOVE FAVORITE
            let videoIdFilter = NSPredicate(format: "id = '\(self.video.id)'")
            guard let videoResult = RealmManager.shared.fetchObjects(Trending.self, filter: videoIdFilter) else {
                completion(false, false)
                return
            }
            if let video = [Trending](videoResult).first {
                RealmManager.shared.delete(object: video) { result in
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
            // ADD FAVORITE
            let copyVideo = Trending(value: self.video)
            RealmManager.shared.add(object: copyVideo) { result in
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
