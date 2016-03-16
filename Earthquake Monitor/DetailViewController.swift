//
//  DetailViewController.swift
//  Earthquake Monitor
//
//  Created by JJLZ on 3/13/16.
//  Copyright © 2016 ESoft. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var lblMag: UILabel!
    @IBOutlet weak var lblDepth: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var earthquake:Earthquake!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //-- Show basic info --
        lblPlace.text = earthquake.place
        lblMag.text = String(earthquake.mag!) + " ML"
        lblDepth.text = String(earthquake.depth!) + " km"
        
        // Date And Time
        let timestamp = earthquake.time! / 1000
        let date = NSDate(timeIntervalSince1970:timestamp)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy - HH:mm"
        let strDate = dateFormatter.stringFromDate(date)
        lblDate.text = strDate
        //--

        //--newcode faltan cosas --//
        //-- Add annotation --
        self.mapView.delegate = self
        
        let annotation = MKPointAnnotation()
        
        // Get location
        let location = CLLocationCoordinate2D(latitude: earthquake.latitude!, longitude: earthquake.longitude!)
        annotation.coordinate = location
        
        annotation.title = "Epicenter"
        
        let span = MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
        let region = MKCoordinateRegion(center: location, span: span)
//        let region = MKCoordinateRegionMakeWithDistance(location, 100000, 100000)
        self.mapView.setRegion(region, animated: true)
        
        // Display the annotation
        self.mapView.showsScale = true
        self.mapView.showAnnotations([annotation], animated: true)
        self.mapView.selectAnnotation(annotation, animated: true)
        //--
    }

    override func didReceiveMemoryWarning() {
        
    }
    
    // MARK: MKMapViewDelegate
    
    /**
    Used to change the color of the pin
    */
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        
        if annotation.isKindOfClass(MKUserLocation) {
            
            return nil
        }
        
        // Reuse the annotation if possible
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }

        // change the color
        annotationView?.pinTintColor = Singleton.sharedInstance.colorForMagnitude(earthquake.mag!)
        
        return annotationView
    }
}

//"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

//"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"

//"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"
