//
//  MapVC.swift
//  IDE Academy
//
//  Created by Mohamed Abdelhamed Ahmed on 11/21/20.
//  Copyright © 2020 IDE Academy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
protocol MapCenterDelegate {
    func setDelailLocationInAddress(delailsAddress:String )
}
class MapVC: UIViewController {
    //MARK:- OutLets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLapelView: UILabel!
    //MARK:- Properties
    var delegate: MapCenterDelegate?
    lazy var geocoder = CLGeocoder()
    //MARK:- Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    //MARK:- Action
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
//MARK:- MapVC function
extension MapVC:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.centerCoordinate
        getNameOfLocation(lat: center.latitude, long: center.longitude)
    }
}
//MARK:- private function
extension MapVC {
    private func getNameOfLocation(lat: CLLocationDegrees, long: CLLocationDegrees){
        let location = CLLocation(latitude: lat, longitude: long)
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error:Error?){
        if error != nil {
            addressLapelView.text = "Unable to Find Address for Location"
        }else{
            if let placemarks = placemarks, let placemark = placemarks.first{
                addressLapelView.text = placemark.compactAddress ?? ""
                delegate?.setDelailLocationInAddress(delailsAddress: placemark.compactAddress ?? "N/A")
                print(placemark.compactAddress ?? "error")
            }else {
                addressLapelView.text = "No Matching Addresses Found"
                delegate?.setDelailLocationInAddress(delailsAddress: "No Matching Addresses Found")
            }
        }
    }
}
