import Foundation

final class MusicViewModel {

    var musicVideos: [Channel] = []
    var pageToken: String = ""

    func getDataChannel(isLoadMore: Bool, completion: @escaping (Bool) -> Void) {
        ApiManager.Snippet.getMusicVideos(pageToken: pageToken) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let musicResult):
                this.pageToken = musicResult.pageToken
                if !isLoadMore {
                    this.musicVideos.removeAll()
                }
                this.musicVideos.append(contentsOf: musicResult.musicVideos)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}

extension MusicViewModel {

    func numberOfItems(in section: Int) -> Int {
        return musicVideos.count
    }

    func getMusicVideos(with indexPath: IndexPath) -> Channel {
        return musicVideos[indexPath.row]
    }
}
