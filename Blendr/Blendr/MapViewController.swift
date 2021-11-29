//
// MapViewController.swift
// Blendr //
// Created by Caleb R Harrington on 11/29/21. //

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var r: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: r.latitude, longitude: r.longitude) // Make the latitude that of the restaraunt
        annotation.title = r.name // Make this the name of the restaraunt
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)

        
        // Do any additional setup after loading the view. }
/*
// MARK: - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // Get the new view controller using segue.destination.
// Pass the selected object to the new view controller.
} */
    }
}
