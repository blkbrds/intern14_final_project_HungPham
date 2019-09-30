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

    struct ChannelSnippet: ApiPath {
        static var path: String { return baseURL / "v3/search?" }
        let pageToken: String
        let maxResults: Int
        let keySearch: String
        let keyID: String
        var urlString: String { return ChannelSnippet.path + "part=snippet&pageToken=\(pageToken)&maxResults=\(maxResults)&order=relevance&q=\(keySearch)&key=\(keyID)" }
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
