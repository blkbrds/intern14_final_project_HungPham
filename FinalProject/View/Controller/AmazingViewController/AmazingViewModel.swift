import Foundation

final class AmazingViewModel {

    var amazingVideos: [Channel] = []
    var pageToken: String = ""

    func getDataChannel(isLoadMore: Bool, completion: @escaping (Bool) -> Void) {
        ApiManager.Snippet.getAmazingVideos(pageToken: pageToken) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let amazingResult):
                this.pageToken = amazingResult.pageToken
                if !isLoadMore {
                    this.amazingVideos.removeAll()
                }
                this.amazingVideos.append(contentsOf: amazingResult.amazingVideos)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}

extension AmazingViewModel {

    func numberOfItems(in section: Int) -> Int {
        return amazingVideos.count
    }

    func getAmazingVideos(with indexPath: IndexPath) -> Channel {
        return amazingVideos[indexPath.row]
    }
}
