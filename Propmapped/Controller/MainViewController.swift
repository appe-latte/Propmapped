//
//  MainViewController.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 28/08/2019.
//  Modified: 27 February 2020
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Crashlytics
import FirebaseAuth

protocol ModalDelegate {
    func applyFilter(radius: Int,propType: String, bedNum : Int)
    func removeFilter();
}

class MainViewController: UIViewController, CLLocationManagerDelegate, ModalDelegate {
    
    // Human interface elements
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var postAdButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var insightsButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    
    // Variables
    private let locationService = LocationService()
    private var pois = [POI]()
    private var poiType: POIType?
    private var mapCenterLocation: CLLocation?
    var SearchPropertyViewController : SearchPropertyViewController!
    let loadingSpinner = LoadingSpinner();
    var properties:[Property]?
    
    private lazy var locationAlert: UIAlertController = {
        let alertController = UIAlertController(title: "Location Authorization", message: "Propmapped can provide your Points of Interest based on your current location. To change location permission please update your Privacy Settings.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let settingsAction = UIAlertAction(title: "Update Settings", style: .default, handler: {(_) in if let url = URL(string: UIApplication.openSettingsURLString){
            UIApplication.shared.open(url)
            }
        })
        
        alertController.addAction(okAction)
        alertController.addAction(settingsAction)
        
        return alertController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationService.delegate = self
        controlView.layer.cornerRadius = 5.0
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.tintColor = UIColor(red:1.00, green:0.56, blue:0.55, alpha:1.0)
        mapCenterLocation = CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude)
        self.setUI();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadingSpinner.showActivityIndicatory(uiView: self.mapView)
        self.loadData();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUI();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setUI() {
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    private func loadData() {
        let downloader = FirebaseDownloadHelper();
        downloader.downloadPropertyData { (propertyArray) in
            print("We have \(String(describing: propertyArray?.count)) properties")
            if let array = propertyArray {
                self.properties = array;
                self.plotProperties(props: array)
            }
        }
    }
    
    // Mark: Modal Delegate
    
    func removeFilter() {
        self.loadingSpinner.showActivityIndicatory(uiView: self.view)
        self.loadData();
    }
    
    func applyFilter(radius: Int, propType: String, bedNum: Int) {
        self.removeAllAnnotations();
        let distanceHelper = DistanceHelpers();
        var tempArray: [Property] = [];
        self.properties?.forEach({ (property) in
            PostCodeHelper().latAndLongFromAddress(postCode: property.postcode ?? "") { (location) in
                if distanceHelper.distanceBetweenTwoLocationsInMiles(cordinateOne: location!, cordinateTwo: self.mapView.userLocation.location!) < radius {
                    // Within radius. Now check type
                    if property.propertyType == propType && property.numberOfBedrooms == bedNum {
                        // within radius and matching type
                        self.removeAllAnnotations()
                        tempArray.append(property);
                        self.plotProperties(props: tempArray);
                    }
                }
            }
        })
    }
    
    @IBAction func filterButton_Clicked(_ sender: Any) {
        self.performSegue(withIdentifier: "filter", sender: self)
    }
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToMenu", sender: self)
    }
    
    @IBAction func insightsButton(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToInsights", sender: self)
    }
    
    @IBAction func postAdButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "post", sender: self);
    }
    
    @IBAction func chatButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "chat", sender: self)
    }
    
    // Returns map to current user location if map was moved
    @IBAction func userLocationTapped(_ sender: UIButton) {
        centerToUserLocation()
    }
    
    //MARK -Toggle between map styles
    @IBAction func mapStyleTapped(_ sender: UIButton) {
        mapView.mapType = mapView.mapType == .standard ? .satellite : .standard
    }
    
    //MARK - Private Function
    private func centerToUserLocation() {
        let mapRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
        
        DispatchQueue.main.async {[weak self] in
            self?.mapView.setRegion(mapRegion, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Property Details
        //
        if segue.identifier == "propDetails" {
            //let vc = segue.destination as! PropertyDetailTableViewController;
            let vc = segue.destination as! PropertyTableViewController;
            vc.property = sender as? Property
        }
        
        if segue.identifier == "filter" {
            let vc = segue.destination as! SearchPropertyViewController;
            vc.delegate = self;
        }
    }
}

extension MainViewController: LocationServiceDelegate {
    
    func setMapRegion(center: CLLocation) {
        let mapRegion = MKCoordinateRegion(center: center.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
        
        DispatchQueue.main.async {[weak self] in
            self?.mapView.setRegion(mapRegion, animated: true)
        }
    }
    
    func authorizationDenied() {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else {return}
            weakSelf.present(weakSelf.locationAlert, animated: true, completion: nil)
        }
    }
}

extension MainViewController : MKMapViewDelegate {
    // Map Annotation and plotting data
    
    private func plotProperties(props:[Property]) {
        self.removeAllAnnotations()
        let ph = PostCodeHelper();
        print("Plotting \(props.count) properties")
        
        for property in props {
            ph.latAndLongFromAddress(postCode: property.postcode ?? "") { (location) in
                
                let annotation = PropertyAnnotation(location: location?.coordinate ?? CLLocationCoordinate2D(), title: "", subtitle: property.propertyType ?? "", propertyId: property.uniqueId ?? "");
                
                DispatchQueue.main.async {
                    self.mapView.addAnnotation(annotation)
                    print("adding annotation \(annotation.coordinate)")
                    self.mapView.reloadInputViews()
                    self.loadingSpinner.stopAnimatingIndicator()
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKMarkerAnnotationView
        if view == nil {
            view = MKMarkerAnnotationView(annotation: nil, reuseIdentifier: "pin")
        }
        view?.annotation = annotation
        view?.displayPriority = .required
        //view?.titleVisibility = .hidden
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if let annotation = view.annotation as? PropertyAnnotation {
            if let property = self.properties?.filter({$0.uniqueId == annotation.propertyId}).first {
                print("This property \(String(describing: property.title))")
                self.performSegue(withIdentifier: "propDetails", sender: property)
            }
        }
    }
    
    private func removeAllAnnotations() {
        let annotations = self.mapView.annotations
        self.mapView.removeAnnotations(annotations);
    }
}

