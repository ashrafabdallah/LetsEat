//
//  NoDataViewUIView.swift
//  LetsEat
//
//  Created by Ashraf Eltantawy on 05/09/2023.
//

import UIKit

class NoDataViewUIView: UIView {
    var view :UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDesc: UILabel!
    override  init(frame:CGRect){
        super.init(frame: frame)
        setupView()
    }
    required init?(coder :NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    func loadViewFromNib()->UIView{
        let nib = UINib(nibName: "NoDataView", bundle: Bundle.main)
        let view = nib.instantiate(withOwner: self,options: nil)[0] as! UIView
        return view
    }
    func setupView(){
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        addSubview(view)
    }
    func set (title:String)
    {
        lblTitle.text=title
    }
    func set(dec:String){
        lblDesc.text=dec
    }

}
