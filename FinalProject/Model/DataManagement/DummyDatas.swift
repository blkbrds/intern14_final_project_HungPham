import Foundation
import UIKit
import CoreLocation

final class DummyDatas {

    var title: String
    var subTitle: String
    var imageMarker: UIImage
    var pinIcon: UIImage
    var coordinate: CLLocationCoordinate2D

    init(title: String, subTitle: String, imageMarker: UIImage, coordinate: CLLocationCoordinate2D, pinIcon: UIImage) {
        self.title = title
        self.subTitle = subTitle
        self.imageMarker = imageMarker
        self.coordinate = coordinate
        self.pinIcon = pinIcon
    }
}

extension DummyDatas {
    static func  datas() -> [DummyDatas] {
        let newDatas: [DummyDatas] = {
            let data1 = DummyDatas(title: "Paris", subTitle: "Paris, France's capital, is a major European city and a global center for art, fashion, gastronomy and culture.",
                                   imageMarker: #imageLiteral(resourceName: "ic-wall3"), coordinate: CLLocationCoordinate2D(latitude: 16.083493, longitude: 108.238017), pinIcon: #imageLiteral(resourceName: "ic-test2"))
            let data2 = DummyDatas(title: "Tokyo", subTitle: "Tokyo, (東京 Tōkyō, English: /ˈtoʊkioʊ/,[7] Japanese: [toːkʲoː] (About this soundlisten)) officially Tokyo Metropolis.",
                                   imageMarker: #imageLiteral(resourceName: "ic-wall5"), coordinate: CLLocationCoordinate2D(latitude: 16.082125, longitude: 108.238751), pinIcon: #imageLiteral(resourceName: "ic-userLocation"))
            let data3 = DummyDatas(title: "Egypt", subTitle: "Egypt, a country linking northeast Africa with the Middle East, dates to the time of the pharaohs.",
                                   imageMarker: #imageLiteral(resourceName: "ic-wall2"), coordinate: CLLocationCoordinate2D(latitude: 16.076166, longitude: 108.232421), pinIcon: #imageLiteral(resourceName: "ic-test3"))
            return [data1, data2, data3]
        }()
        return newDatas
    }
}
