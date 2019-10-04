import Foundation
import UIKit

final class SearchViewModel {

    var searchedVideo: [Channel] = []
    var keySearch: String = ""
    var pageToken: String = ""

    func getSearchData(isLoadMore: Bool, completion: @escaping (Bool) -> Void) {
        ApiManager.Snippet.getSearchData(pageToken: pageToken, keySearch: keySearch) { result in
            switch result {
            case .success(let searchResult):
                self.pageToken = searchResult.pageToken
                if !isLoadMore {
                    self.searchedVideo.removeAll()
                }
                self.searchedVideo.append(contentsOf: searchResult.searchedVideo)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
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
