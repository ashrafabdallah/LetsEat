//
//  DataManager.swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 02/09/2023.
//

import Foundation
protocol DataManager{
    func load(file name:String)->[[String:AnyObject]]
}
extension DataManager{
    func load(file name:String)->[[String:AnyObject]]{
        guard let path = Bundle.main.path(forResource: name, ofType: "plist") , let itemPath = NSArray(contentsOfFile: path) else {
            return [[:]]
        }
        return itemPath as! [[String:AnyObject]]
    }
}
