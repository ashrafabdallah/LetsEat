//
//  MampViewController.swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 02/09/2023.
//

import UIKit
import MapKit
class MampViewController: UIViewController {
let manager = MapDataManager()
    var selectedRestaurant:RestaurantItem?
    @IBOutlet weak var mapview: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapview.delegate=self
        initialize()
    }
    func loadMap(_ annotations:[RestaurantItem]){
        mapview.setRegion(manager.currentRegion(latDelta: 0.5, longDelta: 0.5), animated: true)
        mapview.addAnnotations(manager.annotations)
        
        
    }
    func initialize(){
        manager.fetchData { annotions in
            loadMap(annotions)
        }
    }


}
extension MampViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "custompin"
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        var annotationView: MKAnnotationView?
        if let customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView = customAnnotationView
            annotationView?.annotation = annotation
        } else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "custom-annotation")
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation=view.annotation as? RestaurantItem
        {
            self.selectedRestaurant = annotation
            self.performSegue(withIdentifier: Segue.showDetail.rawValue, sender: self)

        }
//        guard let annotation = mapView.annotations.first else{return}
//        selectedRestaurant = annotation as? RestaurantItem
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier!{
        case Segue.showDetail.rawValue:
            showResturantDeatiles(segue: segue)
            
        default :
            print("Segue not added")
        }
        
    }
    func showResturantDeatiles(segue:UIStoryboardSegue){
        if let viewController = segue.destination as? RestaurantDetailViewController{
            viewController.selectedRestaurant=selectedRestaurant
        }
        
    }
}
