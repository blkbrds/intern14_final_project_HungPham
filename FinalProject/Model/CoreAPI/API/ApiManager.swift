import Foundation
import Alamofire

final class ApiManager {

    struct Path {
        static let baseURL = "https://www.googleapis.com/youtube"
    }

    struct Snippet {}

    struct Downloader {}

}

extension ApiManager.Path {

    struct Snippet: ApiPath {
        static var path: String { return baseURL / "v3/videos?" }
        let chart: String
        let regionCode: String
        let maxResults: Int
        let keyID: String
        var urlString: String { return Snippet.path + "part=snippet,contentDetails,statistics&chart=\(chart)&regionCode=\(regionCode)&maxResults=\(maxResults)&key=\(keyID)" }
    }

    struct SearchSnippet: ApiPath {
        static var path: String { return baseURL / "v3/search?" }
        let maxResults: Int
        let keyID: String
        var urlString: String { return SearchSnippet.path + "part=snippet&maxResults=\(maxResults)&key=\(keyID)" }
    }

    struct CategorySnippet: ApiPath {
        static var path: String { return baseURL / "v3/search?" }
        let maxResults: Int
        var urlString: String { return CategorySnippet.path + "part=snippet&maxResults=\(maxResults)" }
    }

    struct ChannelSnippet: ApiPath {
        static var path: String { return baseURL / "v3/search?" }
        let maxResults: Int
        let keySearch: String
        let keyID: String
        var urlString: String { return ChannelSnippet.path + "part=snippet&maxResults=\(maxResults)&type=channel&order=relevance&q=\(keySearch)&key=\(keyID)" }
    }

    struct ChannelVideosSnippet: ApiPath {
        static var path: String { return baseURL / "v3/search?" }
        let maxResults: Int
        let keyID: String
        var urlString: String { return ChannelVideosSnippet.path + "part=snippet,id&order=date&maxResults=\(maxResults)&key=\(keyID)" }
    }

    struct CommentSnippet: ApiPath {
        static var path: String { return baseURL / "v3/commentThreads?" }
        let keyID: String
        var urlString: String { return CommentSnippet.path + "part=snippet&key=\(keyID)" }
    }
}

protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

private func / (left: String, right: Int) -> String {
    return left.appending(path: "\(right)")
}
