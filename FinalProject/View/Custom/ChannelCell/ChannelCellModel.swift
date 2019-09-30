import Foundation
import UIKit

final class ChannelCellModel {

    var title: String
    var imageURL: String

    init(myChannel: Channel) {
        self.title = myChannel.title
        self.imageURL = myChannel.imageURL
    }
}
