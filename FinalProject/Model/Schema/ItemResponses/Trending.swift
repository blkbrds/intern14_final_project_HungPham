//
//  Trending.swift
//  FinalProject
//
//  Created by PCI0010 on 9/24/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import RealmSwift

final class Trending: Object {
    typealias JSON = [String: Any]

    @objc dynamic var title: String = ""
    @objc dynamic var viewCount: String = ""
    @objc dynamic var duration: String = ""
    @objc dynamic var imageURL: String = ""
    dynamic var videoImage: UIImage?

    convenience init(dic: JSON) {
        var schema: [String: Any] = [:]
        if let snippet = dic["snippet"] as? JSON {
            let title = snippet["title"]
            schema["title"] = title

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
        }
        self.init(value: schema)
    }

    override static func primaryKey() -> String? {
        return "title"
    }
}
