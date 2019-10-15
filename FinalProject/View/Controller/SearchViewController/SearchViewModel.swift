import Foundation
import UIKit

protocol SearchViewModelDelegate: class {
    func handleApiError(error: Error)
}

final class SearchViewModel {

    var searchedVideo: [Channel] = []
    var keySearch: String = ""
    var pageToken: String = ""
    weak var delegate: SearchViewModelDelegate?

    func getSearchData(isLoadMore: Bool, completion: @escaping (Bool) -> Void) {
        ApiManager.Snippet.getSearchData(pageToken: pageToken, keySearch: keySearch) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let searchResult):
                this.pageToken = searchResult.pageToken
                if !isLoadMore {
                    this.searchedVideo.removeAll()
                }
                this.searchedVideo.append(contentsOf: searchResult.searchedVideos)
                completion(true)
            case .failure(let error):
                this.delegate?.handleApiError(error: error)
                completion(false)
            }
        }
    }
}

extension SearchViewModel {

    func numberOfItemsSearch(in section: Int) -> Int {
        return searchedVideo.count
    }

    func getSearchedVideo(with indexPath: IndexPath) -> Channel {
        return searchedVideo[indexPath.row]
    }
}
