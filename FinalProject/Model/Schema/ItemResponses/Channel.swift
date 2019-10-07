import Foundation
import RealmSwift

final class Channel: Object {
    typealias JSON = [String: Any]

    @objc dynamic var title: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var publishedAt: String = ""
    @objc dynamic var descriptionVideo: String = ""
    @objc dynamic var channelId: String = ""

    convenience init(dic: JSON) {
        var schema: [String: Any] = [:]
        if let snippet = dic["snippet"] as? JSON {
            let publishedAt = snippet["publishedAt"]
            schema["publishedAt"] = publishedAt

            let title = snippet["title"]
            schema["title"] = title

            let channelId = snippet["channelId"]
            schema["channelId"] = channelId

            let descriptionVideo = snippet["description"]
            schema["descriptionVideo"] = descriptionVideo

            if let thumbnails = snippet["thumbnails"] as? JSON {
                if let high = thumbnails["high"] as? JSON {
                    let imageURL = high["url"]
                    schema["imageURL"] = imageURL
                }
            }
        }
        self.init(value: schema)
    }

    override static func primaryKey() -> String? {
        return "title"
    }
}
