//
//  RestaurantDetailViewController.swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 04/09/2023.
//

import UIKit
import MapKit


// MARK: RestaurantDetailViewController

class RestaurantDetailViewController: UITableViewController {
    // cell one
    @IBOutlet weak var lblCuisine: UILabel!
    @IBOutlet weak var btnHeart: UIBarButtonItem!
    @IBOutlet weak var lblHeaderAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    // cell two
    @IBOutlet weak var lblTableDetails: UILabel!
    //Cell Three
    @IBOutlet weak var lblOverallRating: UILabel!
    // Cell Eight
    @IBOutlet weak var lblAddress: UILabel!
    // Cell Nine
    @IBOutlet weak var imgMap: UIImageView!
    @IBOutlet weak var ratingsView:RatingsView!
    
    var selectedRestaurant:RestaurantItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(selectedRestaurant as Any)
        initialize()
    }
    
    
}
private extension RestaurantDetailViewController{
    func setupLabels(){
        guard let resturant = selectedRestaurant else{return}
        if let name = resturant.name{
            lblName.text=name
            title=name
        }
        if let cuisine = resturant.subtitle{
            lblCuisine.text=cuisine
        }
        if let address = resturant.address{
            lblAddress.text=address
            lblHeaderAddress.text=address
        }
        lblTableDetails.text="Table for 7, tonight at 10:00 PM"
        
        
    }
    func createMap(){
        guard let annotation = selectedRestaurant
                ,let long = annotation.long ,
              let lat = annotation.lat else{return}
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        takeSanpShout(with:location)
    }
    func takeSanpShout(with location :CLLocationCoordinate2D){
        let mapSnapShoutOptions = MKMapSnapshotter.Options()
        var loc=location
        let polyLine=MKPolygon(coordinates: &loc, count: 1)
        let region = MKCoordinateRegion(polyLine.boundingMapRect)
        mapSnapShoutOptions.region=region
        mapSnapShoutOptions.scale=UIScreen.main.scale
        mapSnapShoutOptions.size = CGSize(width: 340, height: 208)
        mapSnapShoutOptions.showsBuildings=true
        mapSnapShoutOptions.pointOfInterestFilter = .includingAll
        let snapShotter = MKMapSnapshotter(options: mapSnapShoutOptions)
        snapShotter.start { snapShot, error in
            guard let snapShot = snapShot else{return}
            
            UIGraphicsBeginImageContextWithOptions(mapSnapShoutOptions.size, true, 0)
            snapShot.image.draw(at: .zero)
            let identifier = "custompin"
            let annotation = MKPointAnnotation()
            annotation.coordinate=location
            let pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView.image=UIImage(named: "custom-annotation")!
            let pinImage = pinView.image
            var point = snapShot.point(for: location)
            let rect = self.imgMap.bounds
            if rect.contains(point){
                let pinCenteroffest = pinView.centerOffset
                point.x -= pinView.bounds.size.width/2
                point.y -= pinView.bounds.height/2
                point.x += pinCenteroffest.x
                point.y += pinCenteroffest.y
                pinImage?.draw(at: point)
            }
            if let image = UIGraphicsGetImageFromCurrentImageContext(){
                UIGraphicsEndImageContext()
                DispatchQueue.main.async {
                    self.imgMap.image = image
                }
            }
            
            
        }
       
        
    }
    func initialize(){
        setupLabels()
        createMap()
        createRating()
    }
    func createRating(){
        ratingsView.rating=3.5
        ratingsView.isEnabled=true
    }
}
private extension RestaurantDetailViewController{
    @IBAction func unwindReviewCancel(segue:UIStoryboardSegue)
    {
        
    }
}
