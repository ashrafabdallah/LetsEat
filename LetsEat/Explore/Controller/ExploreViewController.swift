//
//  ExploreViewController.swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 31/08/2023.
//

import UIKit

class ExploreViewController: UIViewController {
    let dataManager = ExploreDataManager()
    var headerView :ExploreHeaderView!
    var selectedCity:LocationItem?
    @IBOutlet weak var collectionView: UICollectionView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource=self
        collectionView.delegate=self
       
        dataManager.fetchData()
        
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden=true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden=false
    }
    
    
    // when mark slected city on tableview in locationview
    func showLocationList(segue:UIStoryboardSegue){
      guard  let navController = segue.destination as? UINavigationController , let viewController
                = navController.topViewController as? LocationsViewController else{
          return
      }
        guard let city = selectedCity else{return}
        viewController.selectedCity = city
    }
    
    func showRestaurantListing(segue:UIStoryboardSegue){
        if let viewController = segue.destination as? Restaurant_ListViewController , let city = selectedCity , let index = collectionView.indexPathsForSelectedItems?.first{
            viewController.selectedCity = city
            viewController.selectedType = dataManager.exploreItem[index.row].name
        }
    }
    func showAlert(){
        let alert = UIAlertController(title: "Location Needed", message: "Please select a location."
                                      
                                      , preferredStyle: .alert)
        let okButton  = UIAlertAction(title: "OK", style: .default,handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Segue.restaurantList.rawValue{
            
            guard selectedCity != nil else{
                
                showAlert()
                return false
            }
            return true
           
        }
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case Segue.restaurantList.rawValue:
            showRestaurantListing(segue: segue)
        case Segue.locationList.rawValue:
            showLocationList(segue: segue)
        default:
            print("Segue not added....")
            
        }
    }
    
    @IBAction func unwindLocationCancel(segue:UIStoryboardSegue){
        
    }
   
    @IBAction func unwindLocationDone(segue:UIStoryboardSegue){
       if let locationView = segue.source as? LocationsViewController{
           self.selectedCity = locationView.selectedCity
           if let location = selectedCity{
               headerView.lblLocation.text="\(location.city) \(location.state)"
           }
        }
        
    }
    
    
}
extension ExploreViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.exploreItem.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as? ExploreCellCollectionViewCell{
            let data = dataManager.exploreItem
            cell.nameExplore.text = data[indexPath.row].name
            cell.imageExplore.image = UIImage(named: data[indexPath.row].image)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if  let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? ExploreHeaderView{
            self.headerView = headerView
            return headerView
        }
       return UICollectionReusableView()
    }
 
    
    
}
extension ExploreViewController:UICollectionViewDelegate{}
