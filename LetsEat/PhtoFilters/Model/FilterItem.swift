//
//  FilterItem.swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 09/09/2023.
//

import Foundation
class FilterItem:NSObject{
    let filter:String
    let name:String
    init(dic :[String:AnyObject]){
        self.filter=dic["filter"] as! String
        self.name=dic["name"] as! String
    }
}
