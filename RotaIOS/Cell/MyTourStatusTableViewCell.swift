//
//  MyTourStatusTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 8.08.2021.
//

import UIKit

protocol MyTourStatusTableViewCellDelegate {
    func myTourStatusId(selectedStatusId : String, isremove : Bool)
}

class MyTourStatusTableViewCell: BaseTableViewCell {
    @IBOutlet weak var viewContetView: UIView!
    @IBOutlet weak var viewCheckBoxView: CheckBoxView!
    @IBOutlet weak var labelStatusText: UILabel!
    var myTourStatusTableViewCellDelegate : MyTourStatusTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.viewContetView.backgroundColor = UIColor.grayColor
        self.labelStatusText.textColor = UIColor.white
        self.viewCheckBoxView.checkBoxViewDelegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

extension MyTourStatusTableViewCell: CheckBoxViewDelegate {
    
    func checkBoxTapped(isremember: Bool) {
        if isremember == true {
            if self.labelStatusText.text == "Status" {
                self.myTourStatusTableViewCellDelegate?.myTourStatusId(selectedStatusId: "0", isremove: false)
            }else if self.labelStatusText.text == "Approved" {
                self.myTourStatusTableViewCellDelegate?.myTourStatusId(selectedStatusId: "94", isremove: false)
            }else if self.labelStatusText.text == "Waiting Approval" {
                self.myTourStatusTableViewCellDelegate?.myTourStatusId(selectedStatusId: "95", isremove: false)
            }else if self.labelStatusText.text == "Canceled" {
                self.myTourStatusTableViewCellDelegate?.myTourStatusId(selectedStatusId: "181", isremove: false)
            }else if self.labelStatusText.text == "Rejected" {
                self.myTourStatusTableViewCellDelegate?.myTourStatusId(selectedStatusId: "165", isremove: false)
            }
        }else{
            if self.labelStatusText.text == "Status" {
                self.myTourStatusTableViewCellDelegate?.myTourStatusId(selectedStatusId: "0", isremove: true)
            }else if self.labelStatusText.text == "Approved" {
                self.myTourStatusTableViewCellDelegate?.myTourStatusId(selectedStatusId: "94", isremove: true)
            }else if self.labelStatusText.text == "Waiting Approval" {
                self.myTourStatusTableViewCellDelegate?.myTourStatusId(selectedStatusId: "95", isremove: true)
            }else if self.labelStatusText.text == "Canceled" {
                self.myTourStatusTableViewCellDelegate?.myTourStatusId(selectedStatusId: "181", isremove: true)
            }else if self.labelStatusText.text == "Rejected" {
                self.myTourStatusTableViewCellDelegate?.myTourStatusId(selectedStatusId: "165", isremove: true)
            }
        }
    }
}
