import Foundation
import UIKit
import RealmSwift

final class HomeViewModel {

    var myTrendings: [Trending] = []
    var myChannels: [Channel] = []

    // Mark : - Load Data From API
    func loadDataTrending(completion: @escaping (Bool) -> Void) {
        ApiManager.Snippet.getTrendingData() { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let trendingResult):
                this.myTrendings.append(contentsOf: trendingResult.myTrending)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }

    func loadDataChannel(completion: @escaping (Bool) -> Void) {
        ApiManager.Snippet.getChannelData { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let channelResult):
                this.myChannels.append(contentsOf: channelResult.myChannel)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}

extension HomeViewModel {
    func numberOfItemsTrending(in section: Int) -> Int {
        return myTrendings.count
    }

    func getTrending(with indexPath: IndexPath) -> Trending {
        return myTrendings[indexPath.row]
    }

    func numberOfItemsChannel(in section: Int) -> Int {
        return myChannels.count
    }

    func getChannel(with indexPath: IndexPath) -> Channel {
        return myChannels[indexPath.row]
    }
}
