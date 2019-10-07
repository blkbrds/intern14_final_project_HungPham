import Foundation

final class ChannelVideosViewModel {

    var myChannels: [Channel] = []
    var video: Channel
    var pageToken: String = ""

    init(video: Channel = Channel()) {
        self.video = video
    }

    func getDataChannel(isLoadMore: Bool, completion: @escaping (Bool) -> Void) {
        ApiManager.Snippet.getChannelVideosData(pageToken: pageToken, channelId: video.channelId) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let channelVideosResult):
                this.pageToken = channelVideosResult.pageToken
                if !isLoadMore {
                    this.myChannels.removeAll()
                }
                this.myChannels.append(contentsOf: channelVideosResult.myChannel)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}

extension ChannelVideosViewModel {

    func numberOfItems(in section: Int) -> Int {
        return myChannels.count
    }

    func getChannel(with indexPath: IndexPath) -> Channel {
        return myChannels[indexPath.row]
    }
}
