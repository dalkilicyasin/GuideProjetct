//
//  ExcPaxPageTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 9.12.2021.
//

import UIKit
protocol ExcPaxPageTableViewCellDelegate {
    func checkBoxTapped(checkCounter : Bool, touristName : String, tempPaxes : GetInHoseListResponseModel)
}

class ExcPaxPageTableViewCell: BaseTableViewCell {
    @IBOutlet weak var imageCheck: UIImageView!
    @IBOutlet weak var labelPaxName: UILabel!
    @IBOutlet weak var labelRoomName: UILabel!
    var isTappedCheck = false
    var paxesListInCell : GetInHoseListResponseModel?
    var excPaxPageTableViewCellDelegate : ExcPaxPageTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        //self.imageCheck.image = UIImage(named: "square")
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedChecBox))
        self.imageCheck.isUserInteractionEnabled = true
        self.imageCheck.addGestureRecognizer(gesture)
    }
    
    @objc func tappedChecBox(){
        self.isTappedCheck = !self.isTappedCheck
        self.excPaxPageTableViewCellDelegate?.checkBoxTapped(checkCounter: self.isTappedCheck, touristName: self.labelPaxName.text ?? "", tempPaxes: self.paxesListInCell!)
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

