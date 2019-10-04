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

    struct ChannelLoadMoreResult {
        var myChannel: [Channel] = []
        var pageToken: String
    }

    struct SearchResult {
        var searchedVideos: [Channel] = []
        var pageToken: String
    }

    struct SportResult {
        var sportVideos: [Channel] = []
        var pageToken: String
    }

    struct MusicResult {
        var musicVideos: [Channel] = []
        var pageToken: String
    }

    struct AmazingResult {
        var amazingVideos: [Channel] = []
        var pageToken: String
    }

    struct GamingResult {
        var gamingVideos: [Channel] = []
        var pageToken: String
    }

    struct QuerryString {

        func getCategoryPath() -> String {
            return ApiManager.Path.CategorySnippet(maxResults: App.Number.maxOfResultTrending).urlString
        }

        func getCommentPath() -> String {
            return ApiManager.Path.CommentSnippet(keyID: App.KeyUser.keyIdComment).urlString
        }

        func getTrendingPath() -> String {
            return ApiManager.Path.Snippet(chart: App.String.trendingKeySearch, regionCode: App.String.regionCode, maxResults: App.Number.maxOfResultTrending, keyID: App.KeyUser.keyIdTrending)
                .urlString
        }

        func getChannelPath() -> String {
            return ApiManager.Path.ChannelSnippet(maxResults: App.Number.maxOfResultTrending, keySearch: App.String.channelKeySearch, keyID: App.KeyUser.keyIdChannel)
                .urlString
        }

        func getSearchPath() -> String {
            return ApiManager.Path.SearchSnippet(maxResults: App.Number.maxOfResultTrending, keyID: App.KeyUser.keyIdSearch).urlString
        }
    }

    static func getGamingVideos(pageToken: String, completion: @escaping APICompletion<GamingResult>) {
        let urlString = QuerryString().getCategoryPath() + "&pageToken=\(pageToken)" + "&order=relevance&q=\(App.String.gamingKeySearch)" + "&key=\(App.KeyUser.keyIdGaming)"

        API.shared().request(urlString: urlString) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    let json = data.convertToJSON()
                    guard let nextPageToken = json["nextPageToken"] as? String, let items = json["items"] as? [JSON] else { return }
                    var gamingVideos: [Channel] = []
                    for dic in items {
                        let gamingVideo = Channel(dic: dic)
                        gamingVideos.append(gamingVideo)
                    }
                    let gamingResult = GamingResult(gamingVideos: gamingVideos, pageToken: nextPageToken)
                    completion(.success(gamingResult))
                } else {
                    completion(.failure(.error("Can't Format Data!")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func getAmazingVideos(pageToken: String, completion: @escaping APICompletion<AmazingResult>) {
        let urlString = QuerryString().getCategoryPath() + "&pageToken=\(pageToken)" + "&order=relevance&q=\(App.String.amazingKeySearch)" + "&key=\(App.KeyUser.keyIdAmazing)"

        API.shared().request(urlString: urlString) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    let json = data.convertToJSON()
                    guard let nextPageToken = json["nextPageToken"] as? String, let items = json["items"] as? [JSON] else { return }
                    var amazingVideos: [Channel] = []
                    for dic in items {
                        let amazingVideo = Channel(dic: dic)
                        amazingVideos.append(amazingVideo)
                    }
                    let amazingResult = AmazingResult(amazingVideos: amazingVideos, pageToken: nextPageToken)
                    completion(.success(amazingResult))
                } else {
                    completion(.failure(.error("Can't Format Data!")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func getMusicVideos(pageToken: String, completion: @escaping APICompletion<MusicResult>) {
        let urlString = QuerryString().getCategoryPath() + "&pageToken=\(pageToken)" + "&order=relevance&q=\(App.String.musicKeySearch)" + "&key=\(App.KeyUser.keyIdMusic)"

        API.shared().request(urlString: urlString) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    let json = data.convertToJSON()
                    guard let nextPageToken = json["nextPageToken"] as? String, let items = json["items"] as? [JSON] else { return }
                    var musicVideos: [Channel] = []
                    for dic in items {
                        let musicVideo = Channel(dic: dic)
                        musicVideos.append(musicVideo)
                    }
                    let musicResult = MusicResult(musicVideos: musicVideos, pageToken: nextPageToken)
                    completion(.success(musicResult))
                } else {
                    completion(.failure(.error("Can't Format Data!")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func getSportVideos(pageToken: String, completion: @escaping APICompletion<SportResult>) {
        let urlString = QuerryString().getCategoryPath() + "&pageToken=\(pageToken)" + "&order=relevance&q=\(App.String.sportKeySearch)" + "&key=\(App.KeyUser.keyIdComment)"

        API.shared().request(urlString: urlString) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    let json = data.convertToJSON()
                    guard let nextPageToken = json["nextPageToken"] as? String, let items = json["items"] as? [JSON] else { return }
                    var sportVideos: [Channel] = []
                    for dic in items {
                        let sportVideo = Channel(dic: dic)
                        sportVideos.append(sportVideo)
                    }
                    let sportResult = SportResult(sportVideos: sportVideos, pageToken: nextPageToken)
                    completion(.success(sportResult))
                } else {
                    completion(.failure(.error("Can't Format Data!")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func getChannelLoadMoreData(pageToken: String, completion: @escaping APICompletion<ChannelLoadMoreResult>) {
        let urlString = QuerryString().getChannelPath() + "&pageToken=\(pageToken)"

        API.shared().request(urlString: urlString) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    let json = data.convertToJSON()
                    guard let nextPageToken = json["nextPageToken"] as? String, let items = json["items"] as? [JSON] else { return }
                    var myChannels: [Channel] = []
                    for dic in items {
                        let myChannel = Channel(dic: dic)
                        myChannels.append(myChannel)
                    }
                    let channelLoadMoreReuslt = ChannelLoadMoreResult(myChannel: myChannels, pageToken: nextPageToken)
                    completion(.success(channelLoadMoreReuslt))
                } else {
                    completion(.failure(.error("Can't Format Data!")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
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
