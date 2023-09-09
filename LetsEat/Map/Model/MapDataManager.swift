//
//  MapDataManager.swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 02/09/2023.
//

import Foundation
import MapKit
class MapDataManager:DataManager{
    fileprivate var items :[RestaurantItem]=[]
    var annotations:[RestaurantItem]{
        return items
    }
    func fetchData(completion:(_ annotions:[RestaurantItem])->Void){
//        if items.count>0{
//            items.removeAll()
//        }
//        for data in load(file: "MapLocations"){
//            items.append(RestaurantItem(dic: data))
//        }
//        completion(items)
        let manager=RestaurantDataManager()
        manager.fetch(by: "Boston") { restaurantItem in
            self.items = restaurantItem
            completion(items)
        }
    }
    func currentRegion(latDelta:CLLocationDegrees,longDelta:CLLocationDegrees)->MKCoordinateRegion{
        guard let item = items.first else{
            return MKCoordinateRegion()
        }
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        return MKCoordinateRegion(center: item.coordinate, span: span)
    }
    
}

