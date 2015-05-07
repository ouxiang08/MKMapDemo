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
    var polylines = [CLLocationCoordinate2D]()
    
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
        self.addOverlay()
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
        
        
    }
    // MARK: Data
    func addAnnotation(){
    
        var locationCoordinate2D: CLLocationCoordinate2D = mapView.userLocation.coordinate
        for index in 1...10{
            let annotation:MKPointAnnotation = MKPointAnnotation()
            var longitude: String = String(stringInterpolation: "37.\(index)78834")
            
            annotation.coordinate = CLLocationCoordinate2DMake(longitude._bridgeToObjectiveC().doubleValue, 122.406417)
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
    }
    
    func addOverlay(){
    
        var locationCoordinate2D: CLLocationCoordinate2D = mapView.userLocation.coordinate
        for index in 1...12{
        
            var latitude: String = String(stringInterpolation: "37.\(index)78834")
            var longitude: String = String(stringInterpolation: "122.\(index)406417")
    
            
            polylines.append(CLLocationCoordinate2DMake(latitude._bridgeToObjectiveC().doubleValue, longitude._bridgeToObjectiveC().doubleValue))
        }
        
        var polyline:MKPolyline = MKPolyline(coordinates: &polylines, count: polylines.count)
    
        mapView.addOverlay(polyline)
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
        
        if(overlay.isKindOfClass(MKPolyline.classForCoder())){
        
            let polyline = overlay as! MKPolyline
            var aRenderer: MKPolylineRenderer = MKPolylineRenderer(polyline: polyline)
            aRenderer.fillColor = UIColor.cyanColor().colorWithAlphaComponent(0.2)
            aRenderer.strokeColor = UIColor.blueColor().colorWithAlphaComponent(0.7)
            aRenderer.lineWidth = 3
            return aRenderer
        }
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

