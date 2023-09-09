//
//  FilterManager.swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 09/09/2023.
//

import Foundation
class FilterManager:DataManager{
    func fetch(completion:(_ items:[FilterItem])->Void){
        var items:[FilterItem] = []
        for data in load(file: "FilterData"){
            items.append(FilterItem(dic: data))
        }
        completion(items)
    }
    
}
