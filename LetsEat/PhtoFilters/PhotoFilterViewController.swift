//
//  PhotoFilterViewController.swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 09/09/2023.
//

import UIKit
import AVFoundation
import CoreServices

class PhotoFilterViewController: UIViewController {
    @IBOutlet weak var imgExample: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    var image :UIImage?
    var thumbnail:UIImage?
    let manager = FilterManager()
    var selectedRestaurantID:Int?
    var filters :[FilterItem]=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    
    
    
}
private extension PhotoFilterViewController{
    func initialize(){
        setupCollectionView()
        checkSource()
    }
    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 7, left: 6, bottom: 7, right: 7)
        layout.minimumLineSpacing=7
        layout.minimumInteritemSpacing=0
        collectionView.collectionViewLayout = layout
        collectionView.dataSource=self
        collectionView.delegate=self
    }
    func checkSource(){
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        switch cameraAuthorizationStatus {
        case .authorized:
            self.showCameraUserInterface()
        case .restricted , .denied:
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
                if granted {
                    DispatchQueue.main.sync {
                        self.showCameraUserInterface()
                    }
                }
            }
        }
        
    }
    func showApplyFilter (){
        manager.fetch { items in
            filters = items
            if let image = self.image{
                imgExample.image=image
                collectionView.reloadData()
            }
        }
    }
    @IBAction func onPhotoTapped (_ sender:Any){
        checkSource()
    }
}
extension PhotoFilterViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as? FilterCell{
            let item = filters[indexPath.row]
            if  let img = self.thumbnail{
                cell.set(image: img, item: item)
            }
            
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
extension PhotoFilterViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenRect =  collectionView.frame.size.height
        let screenHt = screenRect - 14
        return CGSize(width: 150, height: screenHt)
    }
    
}
extension PhotoFilterViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func showCameraUserInterface(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate=self
#if targetEnvironment(simulator)
        imagePicker.sourceType=UIImagePickerController.SourceType.photoLibrary
#else
        imagePicker.sourceType=UIImagePickerController.SourceType.camera
        imagePicker.showsCameraControls=true
#endif
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.allowsEditing=true
        self.present(imagePicker, animated: true,completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker:UIImagePickerController){
        picker.dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        if let img = image{
            self.thumbnail = generate(image:img,ratio:CGFloat(102))
            self.image = generate(image: img, ratio: CGFloat(752))
            
            
        }
        picker.dismiss(animated: true){
            self.showApplyFilter()
        }
    }
    func generate(image: UIImage, ratio: CGFloat) -> UIImage {
        let size = image.size
        var croppedSize:CGSize?
        var offsetX:CGFloat = 0.0
        var offsetY:CGFloat = 0.0
        if size.width > size.height {
            offsetX = (size.height - size.width) / 2
            croppedSize = CGSize(width: size.height, height:
                                    size.height)
        } else {
            offsetY = (size.width - size.height) / 2
            croppedSize = CGSize(width: size.width, height:
                                    size.width)
            
        }
        guard let cropped = croppedSize, let cgImage =
                image.cgImage else {
            return UIImage()
        }
        
        let clippedRect = CGRect(x: offsetX * -1, y: offsetY * -1,
                                 width: cropped.width, height: cropped.height)
        let imgRef = cgImage.cropping(to: clippedRect)
        let rect = CGRect(x: 0.0, y: 0.0, width: ratio, height:
                            ratio)
        
        
        UIGraphicsBeginImageContext(rect.size)
        if let ref = imgRef {
            UIImage(cgImage: ref).draw(in: rect)
        }
        let thumbnail =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let thumb = thumbnail else {
            return UIImage()
        }
        return thumb
        
        
        
    }
    
    
}
extension PhotoFilterViewController:ImageFiltering{
    func filterSelected(item: FilterItem) {
        if let img = image {
            if item.filter != "None" {
                imgExample.image = self.apply(filter: item.filter,originalImage: img)
            }else{
                imgExample.image = img
            }
            
            
        }
    }
}

extension PhotoFilterViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = filters[indexPath.row]
        filterSelected(item: item)
    }
}
