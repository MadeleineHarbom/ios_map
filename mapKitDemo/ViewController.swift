//
//  ViewController.swift
//  mapKitDemo
//
//  Created by ksd on 28/10/2019.
//  Copyright © 2019 eaaa. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    
    var country: Country?
    var pin: AnnotationPin?
    
    class AnnotationPin: NSObject, MKAnnotation {
        var coordinate: CLLocationCoordinate2D
        var title: String?
        var subtitle: String?
        
        init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
            self.title = title
            self.subtitle = subtitle
            self.coordinate = coordinate
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let coordinate = CLLocationCoordinate2D(latitude: (country?.latlng[0])!, longitude: (country?.latlng[1])!)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)
        mapView.setRegion(region, animated: true)
        pin = AnnotationPin(title: country?.name ?? "<noName>", subtitle: "", coordinate: coordinate)
        mapView.addAnnotation(pin!)
    }
    
    @IBAction func changeMapType(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            mapView.mapType = .standard
        }
        if sender.selectedSegmentIndex == 1 {
            mapView.mapType = .satellite
        }
    }
    

}


extension ViewController: MKMapViewDelegate {
    // MARK: mapView Delegate functions
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: pin, reuseIdentifier: "pinIdentifier")
        annotationView.image = #imageLiteral(resourceName: "india")
        annotationView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        return annotationView
    }
}
