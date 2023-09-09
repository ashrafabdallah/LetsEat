//
//  ExploreDataManager.swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 02/09/2023.
//

import Foundation
class ExploreDataManager:DataManager{
    var exploreItem :[ExploreItem] = []
    func fetchData(){
        for data in load(file: "ExploreData"){
            exploreItem.append(ExploreItem(dict: data))
        }
    }
}
