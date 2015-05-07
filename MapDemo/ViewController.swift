//
//  ViewController.swift
//  MapDemo
//
//  Created by jiajingjing on 15/5/7.
//  Copyright (c) 2015年 jiajingjing. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {

    
    // MARK: Property
    
    @IBOutlet weak var mapView: MKMapView!
    
    var annotations = [MKPointAnnotation]()
    
    // MARK: View
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authorizationStatus: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        if(authorizationStatus==CLAuthorizationStatus.AuthorizedWhenInUse){
            mapView.showsUserLocation = true
        }
        self.addAnnotation()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        let authorizationStatus: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        if(authorizationStatus==CLAuthorizationStatus.AuthorizedWhenInUse){
            mapView.showsUserLocation = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Event
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        mapView.showAnnotations(annotations, animated: true)
    }
    // MARK: Data
    func addAnnotation(){
    
        var locationCoordinate2D: CLLocationCoordinate2D = mapView.userLocation.coordinate
        for index in 1...100{
            let annotation:MKPointAnnotation = MKPointAnnotation()
            var longitude: String = String(stringInterpolation: "37.\(index)78834")
            
            annotation.coordinate = CLLocationCoordinate2DMake(longitude._bridgeToObjectiveC().doubleValue, 122.406417)
            annotations.append(annotation)
        }
    }
    
    func addOverlay(){
    
    }
    
    //MARK: MKMapViewDelegate

    func mapViewWillStartLoadingMap(mapView: MKMapView!) {
        NSLog("mapViewWillStartLoadingMap")
    }
    
    func mapViewDidFinishLoadingMap(mapView: MKMapView!) {
         NSLog("mapViewDidFinishLoadingMap")
    }
    
    func mapViewDidStopLocatingUser(mapView: MKMapView!) {
         NSLog("mapViewDidStopLocatingUser")
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
//        if(overlay.isKindOfClass(MKPolylineRenderer.classForCoder())){
//        
//            var aRenderer: MKPolylineRenderer = MKPolylineRenderer(polyline: (MKPolyline)overlay))
//            aRenderer.fillColor = UIColor.cyanColor().colorWithAlphaComponent(0.2)
//            aRenderer.strokeColor = UIColor.blueColor().colorWithAlphaComponent(0.7)
//            aRenderer.lineWidth = 3
//            return aRenderer
//        }
        return nil;
    }

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if(annotation.isKindOfClass(MKUserLocation.classForCoder())){
            return nil
        }else if(annotation.isKindOfClass(MKPointAnnotation.classForCoder())){
            var annotationV: MKAnnotationView! = mapView.dequeueReusableAnnotationViewWithIdentifier("MKAnnotationView")
            if(nil == annotationV){
                annotationV = MKAnnotationView(annotation: annotation, reuseIdentifier: "MKAnnotationView")
            }
            annotationV.image = UIImage(named: "annotationView")
            
            return annotationV;
        }else{
            return nil
        }
        
    }
}

