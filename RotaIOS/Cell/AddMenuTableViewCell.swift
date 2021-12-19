//
//  AddMenuTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.12.2021.
//

import UIKit

protocol AddMenuTableViewCellDelegate {
    func checkBoxTapped(checkCounter : Bool, transExtrDesc : String, priceTypeDesc : Int)
}

class AddMenuTableViewCell: BaseTableViewCell {
    @IBOutlet weak var imageCheck: UIImageView!
    @IBOutlet weak var labelTransforExtraName: UILabel!
    @IBOutlet weak var labelPriceType: UILabel!
    var isTappedCheck = false
    var extraListInAddMenuCell : Extras?
    var transferListInAddMenuCell : Transfers?
    var addMenuTableViewCellDelegate : AddMenuTableViewCellDelegate?
    var tourid = 0
    var transExtrDesc = ""
    var extrasDesc = ""
    var priceTypeDesc = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
      
        self.imageCheck.image = UIImage(named: "square")
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedChecBox))
        self.imageCheck.isUserInteractionEnabled = true
        self.imageCheck.addGestureRecognizer(gesture)
        // Initialization code
    }
    
    @objc func tappedChecBox(){
        self.isTappedCheck = !self.isTappedCheck
        self.addMenuTableViewCellDelegate?.checkBoxTapped(checkCounter: self.isTappedCheck, transExtrDesc : self.transExtrDesc, priceTypeDesc: self.priceTypeDesc)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if self.isTappedCheck == true {
            self.imageCheck.image = UIImage(named: "check")
        }else {
            self.imageCheck.image = UIImage(named: "square")
        }
    }
}
