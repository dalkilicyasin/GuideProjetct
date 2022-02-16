//
//  ExcPaxPageTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 9.12.2021.
//

import UIKit
protocol ExcPaxPageTableViewCellDelegate {
    func checkBoxTapped(checkCounter : Bool, touristName : String,  marketGroup : Int, tempPaxes : GetInHoseListResponseModel, paxRoom : String, paxNameLabelSelect : Bool)
}

class ExcPaxPageTableViewCell: BaseTableViewCell {
    @IBOutlet weak var imageCheck: UIImageView!
    @IBOutlet weak var labelPaxName: UILabel!
    @IBOutlet weak var labelRoomName: UILabel!
    @IBOutlet weak var labelAgeGroup: UILabel!
    var isTappedCheck = false
    var isTappedNameLabel = false
    var paxesListInCell : GetInHoseListResponseModel?
    var excPaxPageTableViewCellDelegate : ExcPaxPageTableViewCellDelegate?
    var marketGroup = 0
    var paxRoom = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        //self.imageCheck.image = UIImage(named: "square")
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedChecBox))
        self.imageCheck.isUserInteractionEnabled = true
        self.imageCheck.addGestureRecognizer(gesture)
        
        let gestureNameLabel = UITapGestureRecognizer(target: self, action: #selector(tappedChecBox))
        self.labelPaxName.isUserInteractionEnabled = true
        self.labelPaxName.addGestureRecognizer(gestureNameLabel)
    }
    
    @objc func tappedChecBox(){
        self.isTappedCheck = !self.isTappedCheck
        self.isTappedNameLabel = !self.isTappedNameLabel
        self.excPaxPageTableViewCellDelegate?.checkBoxTapped(checkCounter: self.isTappedCheck, touristName: self.labelPaxName.text ?? "", marketGroup: self.marketGroup, tempPaxes: self.paxesListInCell!, paxRoom: self.paxRoom, paxNameLabelSelect: self.isTappedNameLabel)
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

