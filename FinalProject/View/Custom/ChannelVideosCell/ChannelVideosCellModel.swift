import Foundation

final class ChannelVideosCellModel {

    var title: String
    var imageURL: String

    init(myChannel: Channel) {
        self.title = myChannel.title
        self.imageURL = myChannel.imageURL
    }
}
