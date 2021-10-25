//
//  PaxPageTableViewCell.swift
//  Rota
//
//  Created by Yasin Dalkilic on 23.04.2021.
//

import UIKit
import Foundation

protocol PaxPageTableViewCellDelegate {
    func checkBoxTapped(checkCounter : Bool, touristName : String, tempPaxes : GetInHoseListResponseModel)
}

class PaxPageTableViewCell: BaseTableViewCell{
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var labelPaxNameListCell: UILabel!
    var counter = 0
    var isTappedCheck = false
    var paxPageTableViewCellDelegate : PaxPageTableViewCellDelegate?
    var tempPaxes : GetInHoseListResponseModel?
    @IBOutlet weak var imageUserName: UIImageView!
    @IBOutlet weak var imageCheckBox: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
       // self.checkBoxView.checkBoxViewDelegate = self
        self.imageUserName.isHidden = true
        self.viewContent.backgroundColor = UIColor.grayColor
        self.labelPaxNameListCell.textColor = UIColor.white
        self.imageCheckBox.image = UIImage(named: "square")
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedChecBox))
        self.imageCheckBox.isUserInteractionEnabled = true
        self.imageCheckBox.addGestureRecognizer(gesture)
    }
    
    @objc func tappedChecBox(){
        self.isTappedCheck = !self.isTappedCheck
        self.paxPageTableViewCellDelegate?.checkBoxTapped(checkCounter: self.isTappedCheck , touristName: self.labelPaxNameListCell.text ?? "", tempPaxes: self.tempPaxes!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if self.isTappedCheck == true {
            self.imageCheckBox.image = UIImage(named: "check")
        }else {
            self.imageCheckBox.image = UIImage(named: "square")
        }
    }
}

extension PaxPageTableViewCell : CheckBoxViewDelegate {
    func checkBoxTapped(isremember: Bool) {
        print(isremember)
        
    }
}




