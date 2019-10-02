import Foundation
import UIKit
import RealmSwift

extension ApiManager.Snippet {

    struct CommentResult {
        var myComments: [Comment] = []
    }

    static func getCommentData(videoId: String, completion: @escaping APICompletion<CommentResult>) {
        let urlString = QuerryString().getCommentPath() + "&videoId=\(videoId)"
        API.shared().request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                if let data = data {
                    let json = data.convertToJSON()
                    guard let items = json["items"] as? [JSON] else { return }
                    var myComments: [Comment] = []
                    for dic in items {
                        let myComment = Comment(dic: dic)
                        myComments.append(myComment)
                    }
                    let commentResult = CommentResult(myComments: myComments)
                    completion(.success(commentResult))
                } else {
                    completion(.failure(.error("Can't Format Data Comment!")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
