//
//  FilterCell.swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 09/09/2023.
//

import UIKit

class FilterCell: UICollectionViewCell {
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var imgThumb :UIImageView!
}
extension FilterCell:ImageFiltering{
    func set(image:UIImage,item:FilterItem){
        if item.filter != "None" {
            let filteredImg=apply(filter: item.filter, originalImage: image)
            imgThumb.image = filteredImg
            
        }else{
            imgThumb.image=image
        }
        lblName.text=item.name
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        imgThumb.layer.cornerRadius = 9
        imgThumb.layer.masksToBounds=true
    }
}
