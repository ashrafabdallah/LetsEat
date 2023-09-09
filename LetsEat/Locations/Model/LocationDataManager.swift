//
//  LocationDataManager.swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 02/09/2023.
//

import Foundation
class LocationDataManager:DataManager{
    var arrayOfLocation:[LocationItem]=[]
    func fetchData(){
        for data in load(file: "Locations")
        {
            arrayOfLocation.append(LocationItem(dic: data))
        }
    }

}
