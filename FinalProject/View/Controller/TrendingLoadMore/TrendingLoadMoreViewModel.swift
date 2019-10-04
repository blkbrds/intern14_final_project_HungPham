import Foundation
import UIKit

final class TrendingLoadMoreViewModel {

    var myTrendings: [Trending] = []
    var token: String = ""

    func getDataTrending(isLoadMore: Bool, completion: @escaping (Bool) -> Void) {
        ApiManager.Snippet.getTrendingLoadMoreData(pageToken: token) { (result) in
            switch result {
            case .success(let trendingLoadMoreResult):
                self.token = trendingLoadMoreResult.pageToken
                if !isLoadMore {
                    self.myTrendings.removeAll()
                }
                self.myTrendings.append(contentsOf: trendingLoadMoreResult.myTrending)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}

extension TrendingLoadMoreViewModel {

    func numberOfItemsTrending(in section: Int) -> Int {
        return myTrendings.count
    }

    func getTrending(with indexPath: IndexPath) -> Trending {
        return myTrendings[indexPath.row]
    }
}
