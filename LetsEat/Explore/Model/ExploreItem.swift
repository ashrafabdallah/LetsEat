//
//  ExplorItem.swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 02/09/2023.
//

import Foundation
struct ExploreItem{
    var name : String
    var image :String
}
extension ExploreItem{
   
    init(dict:[String:AnyObject])
    {
        self.name = dict["name"] as! String
        self.image = dict["image"] as! String
    }
}
