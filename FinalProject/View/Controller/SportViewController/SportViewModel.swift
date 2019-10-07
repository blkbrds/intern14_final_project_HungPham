import Foundation

final class SportViewModel {

    var sportVideos: [Channel] = []
    var pageToken: String = ""

    func getDataChannel(isLoadMore: Bool, completion: @escaping (Bool) -> Void) {
        ApiManager.Snippet.getSportVideos(pageToken: pageToken) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let sportResult):
                this.pageToken = sportResult.pageToken
                if !isLoadMore {
                    this.sportVideos.removeAll()
                }
                this.sportVideos.append(contentsOf: sportResult.sportVideos)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}

extension SportViewModel {

    func numberOfItems(in section: Int) -> Int {
        return sportVideos.count
    }

    func getSportVideos(with indexPath: IndexPath) -> Channel {
        return sportVideos[indexPath.row]
    }
}
