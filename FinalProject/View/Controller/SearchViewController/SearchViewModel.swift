import Foundation
import UIKit

final class SearchViewModel {

    var mySearchs: [Channel] = []
    var keySearch: String = ""
    var pageToken: String = ""

    func getSearchData(isLoadMore: Bool, completion: @escaping (Bool) -> Void) {
        ApiManager.Snippet.getSearchData(pageToken: pageToken, keySearch: keySearch) { (result) in
            switch result {
            case .success(let searchResult):
                self.pageToken = searchResult.pageToken
                if !isLoadMore {
                    self.mySearchs.removeAll()
                }
                self.mySearchs.append(contentsOf: searchResult.mySearch)
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
        return mySearchs.count
    }

    func getSearch(with indexPath: IndexPath) -> Channel {
        return mySearchs[indexPath.row]
    }
}
