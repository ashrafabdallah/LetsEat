//
//  ReviewFormViewController.swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 09/09/2023.
//

import UIKit

class ReviewFormViewController: UITableViewController {

    @IBOutlet weak var tvReview: UITextView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var ratingsView: RatingsView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func onSaveTapped(_ sender: Any) {
        print(ratingsView.rating)
        print(tfName.text as Any)
        print(tfTitle.text as Any)
        print(tvReview.text as Any)
        dismiss(animated: true)
        
    }
}
