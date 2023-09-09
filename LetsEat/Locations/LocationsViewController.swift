//
//  LocationsViewController.swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 31/08/2023.
//

import UIKit

class LocationsViewController: UIViewController {
let locationDataManager = LocationDataManager()
    var selectedCity:LocationItem?
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource=self
        tableview.delegate=self
        locationDataManager.fetchData()
    }
    

}
extension LocationsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationDataManager.arrayOfLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        
        let data=locationDataManager.arrayOfLocation
        cell.textLabel?.text="\(data[indexPath.row].city) , \(data[indexPath.row].state)"
        if data[indexPath.row].city == selectedCity?.city
        {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
 
    
    
}
extension LocationsViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data=locationDataManager.arrayOfLocation
        selectedCity = data[indexPath.row]
       // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
 
}
