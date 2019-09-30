import Foundation
import UIKit
import RealmSwift

extension ApiManager.Snippet {
    struct TrendingResult {
        var myTrending: [Trending] = []
    }

    struct QuerryString {
        func getTrendingPath() -> String {
            return ApiManager.Path.Snippet(chart: App.String.trendingKeySearch, regionCode: App.String.regionCode, maxResults: App.Number.maxOfResultTrending, keyID: App.KeyUser.keyID).urlString
        }
    }

    static func getTrendingData(completion: @escaping APICompletion<TrendingResult>) {
        let urlString = QuerryString().getTrendingPath()

        API.shared().request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                if let data = data {
                    let json = data.convertToJSON()
                    guard let items = json["items"] as? [JSON] else { return }
                    var myTrendings: [Trending] = []
                    for dic in items {
                        let myTrending = Trending(dic: dic)
                        myTrendings.append(myTrending)
                    }
                    let trendingResult = TrendingResult(myTrending: myTrendings)
                    completion(.success(trendingResult))
                } else {
                    completion(.failure(.error("Can't Format Data.")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
