import Foundation
import RealmSwift

final class Comment: Object {
    typealias JSON = [String: Any]

    @objc dynamic var id: String = ""
    @objc dynamic var authorDisplayName: String = ""
    @objc dynamic var authorProfileImageUrl: String = ""
    @objc dynamic var textOriginal: String = ""

    convenience init(dic: JSON) {
        var schema: [String: Any] = [:]
        if let id = dic["id"] as? String {
            schema["id"] = id
        }

        if let snippet = dic["snippet"] as? JSON {
            if let topLevelComment = snippet["topLevelComment"] as? JSON {
                if let snippet = topLevelComment["snippet"] as? JSON {
                    let textOriginal = snippet["textOriginal"]
                    schema["textOriginal"] = textOriginal

                    let authorDisplayName = snippet["authorDisplayName"]
                    schema["authorDisplayName"] = authorDisplayName

                    let authorProfileImageUrl = snippet["authorProfileImageUrl"]
                    schema["authorProfileImageUrl"] = authorProfileImageUrl
                }
            }
        }
        self.init(value: schema)
    }
    override static func primaryKey() -> String? {
        return "id"
    }
}
