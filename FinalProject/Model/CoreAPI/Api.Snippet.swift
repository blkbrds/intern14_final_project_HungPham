import Foundation
import UIKit
import RealmSwift

extension ApiManager.Snippet {

    struct TrendingResult {
        var myTrending: [Trending] = []
    }

    struct TrendingLoadMoreResult {
        var myTrending: [Trending] = []
        var pageToken: String
    }

    struct ChannelResult {
        var myChannel: [Channel] = []
    }

    struct SearchResult {
        var searchedVideos: [Channel] = []
        var pageToken: String
    }

    struct QuerryString {

        func getCommentPath() -> String {
            return ApiManager.Path.CommentSnippet(keyID: App.KeyUser.keyIdComment).urlString
        }

        func getTrendingPath() -> String {
            return ApiManager.Path.Snippet(chart: App.String.trendingKeySearch, regionCode: App.String.regionCode, maxResults: App.Number.maxOfResultTrending, keyID: App.KeyUser.keyIdTrending)
                .urlString
        }

        func getChannelPath() -> String {
            return ApiManager.Path.ChannelSnippet(pageToken: App.String.token, maxResults: App.Number.maxOfResultTrending, keySearch: App.String.channelKeySearch, keyID: App.KeyUser.keyIdChannel)
                .urlString
        }

        func getSearchPath() -> String {
            return ApiManager.Path.SearchSnippet(maxResults: App.Number.maxOfResultTrending, keyID: App.KeyUser.keyIdSearch).urlString
        }
    }

    static func getSearchData(pageToken: String, keySearch: String, completion: @escaping APICompletion<SearchResult>) {
        let urlString = QuerryString().getSearchPath() + "&pageToken=\(pageToken)" + "&order=relevance&q=\(keySearch)"

        API.shared().request(urlString: urlString) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    let json = data.convertToJSON()
                    guard let nextPageToken = json["nextPageToken"] as? String, let items = json["items"] as? [JSON] else { return }
                    var searchedVideos: [Channel] = []
                    for dic in items {
                        let searchedVideo = Channel(dic: dic)
                        searchedVideos.append(searchedVideo)
                    }
                    let searchResult = SearchResult(searchedVideos: searchedVideos, pageToken: nextPageToken)
                    completion(.success(searchResult))
                } else {
                    completion(.failure(.error("Can't Format Data!")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func getChannelData(completion: @escaping APICompletion<ChannelResult>) {
        let urlString = QuerryString().getChannelPath()

        API.shared().request(urlString: urlString) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    let json = data.convertToJSON()
                    guard let items = json["items"] as? [JSON] else { return }
                    var myChannels: [Channel] = []
                    for dic in items {
                        let myChannel = Channel(dic: dic)
                        myChannels.append(myChannel)
                    }
                    let channelReuslt = ChannelResult(myChannel: myChannels)
                    completion(.success(channelReuslt))
                } else {
                    completion(.failure(.error("Can't Format Data!")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func getTrendingLoadMoreData(pageToken: String, completion: @escaping APICompletion<TrendingLoadMoreResult>) {
        let urlString = QuerryString().getTrendingPath() + "&pageToken=\(pageToken)"
        API.shared().request(urlString: urlString) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    let json = data.convertToJSON()
                    guard let nextPageToken = json["nextPageToken"] as? String, let items = json["items"] as? [JSON] else { return }
                    var myTrendingds: [Trending] = []
                    for dic in items {
                        let myTrending = Trending(dic: dic)
                        myTrendingds.append(myTrending)
                    }
                    let trendingLoadMoreResult = TrendingLoadMoreResult(myTrending: myTrendingds, pageToken: nextPageToken)
                    completion(.success(trendingLoadMoreResult))
                } else {
                    completion(.failure(.error("Can't Format Data!")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func getTrendingData(completion: @escaping APICompletion<TrendingResult>) {
        let urlString = QuerryString().getTrendingPath()

        API.shared().request(urlString: urlString) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    let json = data.convertToJSON()
                    guard let items = json["items"] as? [JSON] else { return }
                    var myTrendings: [Trending] = []
                    for dic in items {
                        let myTrending = Trending(dic: dic)
                        myTrendings.append(myTrending)
                    }
                    let trendingResult = TrendingResult(myTrending: myTrendings)
                    completion(.success(trendingResult))
                } else {
                    completion(.failure(.error("Can't Format Data.")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
