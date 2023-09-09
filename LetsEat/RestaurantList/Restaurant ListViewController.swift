//
//  Restaurant ListViewController.swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 31/08/2023.
//

import UIKit

class Restaurant_ListViewController: UIViewController {
    var selectedRestaurant:RestaurantItem?
    var selectedCity:LocationItem?
    var selectedType:String? // stores the cuisine you picked on the Explore screen.
    var resturantManager = RestaurantDataManager()
    var resturantArray:[RestaurantItem]=[]
    
  
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate=self
        collectionView.dataSource=self
    }
   
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpTitle()
        createData()
        navigationController?.navigationBar.prefersLargeTitles=false
       
       
        
    }
    func showRestaurantDetail(segue:UIStoryboardSegue){
        if let viewcontroller = segue.destination as? RestaurantDetailViewController? ,let index = collectionView.indexPathsForSelectedItems?.first{
            viewcontroller?.selectedRestaurant = resturantManager.restaurantItem[index.row]
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            switch identifier{
            case Segue.showDetail.rawValue:
                showRestaurantDetail(segue: segue)
            default :
                print("Segue not added")
            }
            
        }
    }
    func setUpTitle(){
        navigationController?.setNavigationBarHidden(false, animated: false)
        if let city = selectedCity?.city , let state = selectedCity?.state{
            title = "\(city.uppercased()), \(state.uppercased())"

            navigationController?.navigationBar.prefersLargeTitles=true
        }
    }
    func createData(){
        guard let location = selectedCity?.city , let filter = selectedType else{return}
        resturantManager.fetch(by: location,with: filter) {[weak self] restaurantItem in
            guard let self = self else{return}
            if resturantManager.restaurantItem.count > 0 {
                collectionView.backgroundView = nil
                self.resturantArray=restaurantItem
            }else{
                print("No data")
                let view = NoDataViewUIView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
                view.set(title: "Restaurants")
                view.set(dec: "No restaurants found.")
                collectionView.backgroundView=view
            }
            collectionView.reloadData()
        }
    }


}

extension Restaurant_ListViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resturantArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.RestaurantCollectionViewCell.rawValue, for: indexPath) as? RestaurantCollectionViewCell{
            let resturantData = resturantArray[indexPath.row]
            if let name = resturantData.name{
                cell.labelOne.text=name
            }
            if let cuisine = resturantData.subtitle{
                cell.labelTwo.text=cuisine
            }
            if let imageUrl = resturantData.imageUrl{
                if let url = URL(string: imageUrl){
                    let data = try? Data(contentsOf: url)
                    if let imageData = data{
                        DispatchQueue.main.async {
                            cell.restImageView.image = UIImage(data: imageData)
                        }
                    }
                    
                }
            }
          
           
            return cell
    }
        return UICollectionViewCell()
    }
    
    
}
extension Restaurant_ListViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate and return the desired size for your cell
        let cellWidth: CGFloat = collectionView.bounds.width // Set cell width to match the collection view's width
        let cellHeight: CGFloat = 100.0 // Set your desired cell height here
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
