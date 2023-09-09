//
//  RestaurantDataManager.swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 04/09/2023.
//

import Foundation
class RestaurantDataManager{
    var restaurantItem:[RestaurantItem]=[]
    func fetch(by location:String,with filter:String="All",completion:(_ restaurantItem:[RestaurantItem])->Void){
        if let url = Bundle.main.url(forResource: location, withExtension: "json"){
            do{
                let data = try Data(contentsOf: url)
                let resurants = try JSONDecoder().decode([RestaurantItem].self, from: data)
                if filter != "All"{
                    restaurantItem = resurants.filter({ ($0.cuisines.contains(filter))})

                    
                }else{
                    restaurantItem = resurants
                }
                
            }catch(let e){
                print(e)
            }
            completion(restaurantItem)
        }
    }
}
