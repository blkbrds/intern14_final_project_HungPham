import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces
import Alamofire
import SwiftyJSON

final class MapViewController: UIViewController {

    var locationManager = CLLocationManager()
    var states: [DummyDatas] = DummyDatas.datas()
    var customInfoWindow: CustomInfoWindow?
    var tappedMarker: GMSMarker?

    @IBOutlet private weak var subView: UIView!
    @IBOutlet private weak var mapView: GMSMapView!
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configPin()
    }

    private func configUI() {
        title = "Google Map"
        navigationController?.navigationBar.backgroundColor = .red

        collectionView.register(UINib(nibName: "MapCell", bundle: nil), forCellWithReuseIdentifier: "cell10")
        collectionView.dataSource = self
        collectionView.delegate = self

        tappedMarker = GMSMarker()
        customInfoWindow = CustomInfoWindow().loadView()
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }

    private func configPin() {
        for state in states {
            let markerImage = UIImage(named: "ic-test3")
            let markerView = UIImageView(image: markerImage)
            let stateMarker = GMSMarker()
            stateMarker.position = state.coordinate
            stateMarker.title = state.title
            stateMarker.snippet = state.subTitle
            stateMarker.iconView = markerView
            stateMarker.icon = state.imageMarker
            stateMarker.map = mapView
        }
    }

    func drawPath(startLocation: CLLocation, endLocation: CLLocation) {
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"

        let url = ""
    }

    @IBAction func currentLocationButton(_ sender: Any) {
        self.locationManager.startUpdatingLocation()
    }
}

extension MapViewController: GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        NSLog("marker was tapped")
        tappedMarker = marker
        // get position of tapped marker
        let position = marker.position
        mapView.animate(toLocation: position)
        let point = mapView.projection.point(for: position)
        let newPoint = mapView.projection.coordinate(for: point)
        let camera = GMSCameraUpdate.setTarget(newPoint)
        mapView.animate(with: camera)

        let opaqueWhite = UIColor(white: 1, alpha: 0.85)
        customInfoWindow?.delegate = self
        customInfoWindow?.layer.backgroundColor = opaqueWhite.cgColor
        customInfoWindow?.layer.cornerRadius = 8
        customInfoWindow?.center = mapView.projection.point(for: position)
//        customInfoWindow?.center.y -= 100
        customInfoWindow?.placeTitle.text = marker.title
        customInfoWindow?.placeSubTitle.text = marker.snippet
        customInfoWindow?.placeImageView.image = marker.icon
        guard let customInfoWindows = customInfoWindow else { return true }
        self.mapView.addSubview(customInfoWindows)
        return false
    }

    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        guard let position = tappedMarker?.position else { return }
        customInfoWindow?.center = mapView.projection.point(for: position)
        customInfoWindow?.center.y -= 70
    }

    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return UIView()
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        subView.alpha = 0
        customInfoWindow?.removeFromSuperview()
    }
}

extension MapViewController: CLLocationManagerDelegate {

    // Mark : Jump to Current Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else { return }
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15)
        mapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
}

extension MapViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell10", for: indexPath) as? MapCell else { return UICollectionViewCell() }
        cell.placeTitle.text = states[0].title
        cell.placeSubTitle.text = states[0].subTitle
        cell.placeImageView.image = states[0].imageMarker
        return cell
    }
}

extension MapViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 394, height: 110)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
    }
}

extension MapViewController: CustomInfoWindowDelegate {

    func tapDetail(_ infoView: CustomInfoWindow, sender: UIButton) {
        subView.alpha = 1
    }
}

extension MapViewController: MapCellDelegate {

    func tapRoute(_ mapCellView: MapCell, sender: UIButton) {
        <#code#>
    }
}
