//
//  RestaurantItem .swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 02/09/2023.
//

import UIKit
import MapKit

class RestaurantItem: NSObject,Decodable {
    var name:String?
    var cuisines:[String]=[]
    var lat:Double?
    var long:Double?
    var address:String?
    var postalCode:String?
    var state:String?
    var imageUrl:String?
    var resturantId:Int?
    
    
    enum CodingKeys:String ,CodingKey{
        case name
        case cuisines
        case lat
        case long
        case address
        case postalCode = "postal_code"
        case state
        case imageUrl = "image_url"
        case resturantId = "id"
        
    }
    
    
//    init(dic:[String:AnyObject]) {
//        if let lat = dic["lat"] as? Double{
//            self.lat=lat
//        }
//        if let long = dic["long"] as? Double{
//            self.long=long
//        }
//        if let name = dic["name"] as? String{
//            self.name=name
//        }
//        if let cuisines = dic["cuisines"] as? [String]{
//            self.cuisines=cuisines
//        }
//        if let address = dic["address"] as? String{
//            self.address=address
//        }
//        if let postalCode = dic["postalCode"] as? String{
//            self.postalCode=postalCode
//        }
//        if let state = dic["state"] as? String{
//            self.state=state
//        }
//        if let imageUrl = dic["image_url"] as? String{
//            self.imageUrl=imageUrl
//        }
//        if let resturantId = dic["id"] as? Int{
//            self.resturantId=resturantId
//        }
//    }
}
extension RestaurantItem:MKAnnotation{
    var coordinate: CLLocationCoordinate2D {
        guard let lat = lat , let long = long else{
            return CLLocationCoordinate2D()
        }
       return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    var title:String?{
        return name
    }
    var subtitle: String?{
        if cuisines.isEmpty{
            return ""
        }else if cuisines.count==1{
            return cuisines.first
        }else{
            return cuisines.joined(separator: ",")
        }
    }
    
    
}

