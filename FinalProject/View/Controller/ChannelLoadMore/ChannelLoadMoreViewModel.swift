import Foundation

final class ChannelLoadMoreViewModel {

    var myChannels: [Channel] = []
    var pageToken: String = ""

    func getDataChannel(isLoadMore: Bool, completion: @escaping (Bool) -> Void) {
        ApiManager.Snippet.getChannelLoadMoreData(pageToken: pageToken) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let channelLoadMoreReuslt):
                this.pageToken = channelLoadMoreReuslt.pageToken
                if !isLoadMore {
                    this.myChannels.removeAll()
                }
                this.myChannels.append(contentsOf: channelLoadMoreReuslt.myChannel)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}

extension ChannelLoadMoreViewModel {

    func numberOfItems(in section: Int) -> Int {
        return myChannels.count
    }

    func getChannel(with indexPath: IndexPath) -> Channel {
        return myChannels[indexPath.row]
    }
}
