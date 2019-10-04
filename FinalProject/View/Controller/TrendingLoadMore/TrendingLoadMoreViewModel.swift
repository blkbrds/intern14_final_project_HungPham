import Foundation
import UIKit

final class TrendingLoadMoreViewModel {

    var myTrendings: [Trending] = []
    var token: String = ""

    func getDataTrending(isLoadMore: Bool, completion: @escaping (Bool) -> Void) {
        ApiManager.Snippet.getTrendingLoadMoreData(pageToken: token) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let trendingLoadMoreResult):
                this.token = trendingLoadMoreResult.pageToken
                if !isLoadMore {
                    this.myTrendings.removeAll()
                }
                this.myTrendings.append(contentsOf: trendingLoadMoreResult.myTrending)
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
