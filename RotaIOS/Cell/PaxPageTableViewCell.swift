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
    @IBOutlet weak var checkBoxView: CheckBoxView!
    var counter = 0
    var paxIsSelected : Bool?
    var paxPageTableViewCellDelegate : PaxPageTableViewCellDelegate?
    var tempPaxes : GetInHoseListResponseModel?
    @IBOutlet weak var imageUserName: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.checkBoxView.checkBoxViewDelegate = self
        self.imageUserName.isHidden = true
        self.viewContent.backgroundColor = UIColor.grayColor
        self.labelPaxNameListCell.textColor = UIColor.white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension PaxPageTableViewCell : CheckBoxViewDelegate {
    func checkBoxTapped(isremember: Bool) {
        print(isremember)
        self.paxPageTableViewCellDelegate?.checkBoxTapped(checkCounter: isremember, touristName: self.labelPaxNameListCell.text ?? "", tempPaxes: self.tempPaxes!)
    }
}




