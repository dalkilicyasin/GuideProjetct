//
//  CheckBoxCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 23.04.2021.
//


import UIKit

protocol CheckBoxViewDelegate {
    func checkBoxTapped(isremember : Bool)
}

class CheckBoxView: UIView{
    
    @IBOutlet var viewCheckBox: UIView!
    @IBOutlet weak var imageCheck: UIImageView!
    
    var checkBoxViewDelegate : CheckBoxViewDelegate?
    var isCheckRemember = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: CheckBoxView.self), owner: self, options: nil)
        viewCheckBox.addCustomContainerView(self)
        imageCheck.isHidden = true
        viewCheckBox.layer.borderWidth = 0.5
        viewCheckBox.layer.borderColor = UIColor.lightGray.cgColor
        viewCheckBox.layer.cornerRadius = 4
        imageCheck.layer.cornerRadius = 5
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTabCheckbox))
        viewCheckBox.addGestureRecognizer(gesture)
    }
    
    @objc func didTabCheckbox() {
        self.isCheckRemember = !isCheckRemember
        if self.isCheckRemember{
           imageCheck.isHidden = false
            self.checkBoxViewDelegate?.checkBoxTapped(isremember: true)
        }else {
            imageCheck.isHidden = true
            self.checkBoxViewDelegate?.checkBoxTapped(isremember: false)
        }
        
       
    }
}


