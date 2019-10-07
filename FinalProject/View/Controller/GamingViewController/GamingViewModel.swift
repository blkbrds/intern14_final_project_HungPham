import Foundation

final class GamingViewModel {

    var gamingVideos: [Channel] = []
    var pageToken: String = ""

    func getDataChannel(isLoadMore: Bool, completion: @escaping (Bool) -> Void) {
        ApiManager.Snippet.getGamingVideos(pageToken: pageToken) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let gamingResult):
                this.pageToken = gamingResult.pageToken
                if !isLoadMore {
                    this.gamingVideos.removeAll()
                }
                this.gamingVideos.append(contentsOf: gamingResult.gamingVideos)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}

extension GamingViewModel {

    func numberOfItems(in section: Int) -> Int {
        return gamingVideos.count
    }

    func getGamingVideos(with indexPath: IndexPath) -> Channel {
        return gamingVideos[indexPath.row]
    }
}
