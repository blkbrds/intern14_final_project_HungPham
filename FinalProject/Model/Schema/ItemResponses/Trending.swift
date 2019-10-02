import Foundation
import RealmSwift

final class Trending: Object {
    typealias JSON = [String: Any]

    @objc dynamic var descriptionDetail: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var duration: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var publishedAt: String = ""
    @objc dynamic var likeCount: String = ""
    @objc dynamic var dislikeCount: String = ""
    @objc dynamic var viewCount: String = ""

    convenience init(dic: JSON) {
        var schema: [String: Any] = [:]
        if let id = dic["id"] as? String {
            schema["id"] = id
        }
        if let snippet = dic["snippet"] as? JSON {
            let title = snippet["title"]
            schema["title"] = title

            if let descriptionDetail = snippet["description"] as? String {
                schema["descriptionDetail"] = descriptionDetail
            }

            if let publishedAt = snippet["publishedAt"] as? String {
                schema["publishedAt"] = publishedAt
            }

            if let thumbnails = snippet["thumbnails"] as? JSON {
                if let standard = thumbnails["standard"] as? JSON {
                    let imageURL = standard["url"]
                    schema["imageURL"] = imageURL
                }
            }
        }
        if let contentDetails = dic["contentDetails"] as? JSON {
            let duration = contentDetails["duration"]
            schema["duration"] = duration
        }
        if let statistics = dic["statistics"] as? JSON {
            let viewCount = statistics["viewCount"]
            schema["viewCount"] = viewCount

            let likeCount = statistics["likeCount"]
            schema["likeCount"] = likeCount

            let dislikeCount = statistics["dislikeCount"]
            schema["dislikeCount"] = dislikeCount
        }
        self.init(value: schema)
    }

    override static func primaryKey() -> String? {
        return "title"
    }
}
