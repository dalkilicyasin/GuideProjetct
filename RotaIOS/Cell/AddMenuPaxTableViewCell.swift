//
//  AddMenuPaxTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 16.12.2021.
//

import UIKit

protocol AddMenuPaxTableViewCellDelegate {
    func addMenuPaxcheckBoxTapped(checkCounter : Bool, touristName : String, tempPaxes : GetInHoseListResponseModel)
}

class AddMenuPaxTableViewCell: BaseTableViewCell {
    @IBOutlet weak var imageCheck: UIImageView!
    @IBOutlet weak var labelPaxName: UILabel!
    @IBOutlet weak var labelRoomName: UILabel!
    @IBOutlet weak var viewContentView: UIView!
    var isTappedCheck = false
    var paxesListInCell : GetInHoseListResponseModel?
    var addMenuPaxTableViewCellDelegate : AddMenuPaxTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedChecBox))
        self.imageCheck.isUserInteractionEnabled = true
        self.imageCheck.addGestureRecognizer(gesture)
        self.imageCheck.image = UIImage(named: "square")
    }
    
    @objc func tappedChecBox(){
        self.isTappedCheck = !self.isTappedCheck
        self.addMenuPaxTableViewCellDelegate?.addMenuPaxcheckBoxTapped(checkCounter: self.isTappedCheck, touristName: self.labelPaxName.text ?? "", tempPaxes: self.paxesListInCell!)
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

