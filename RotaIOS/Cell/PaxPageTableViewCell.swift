//
//  PaxPageTableViewCell.swift
//  Rota
//
//  Created by Yasin Dalkilic on 23.04.2021.
//

import UIKit

protocol PaxPageCounterDelegate {
    func checkboxCounter(checkCounter : Bool)
}

class PaxPageTableViewCell: BaseTableViewCell{

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var checkBoxView: CheckBoxView!
    var counter = 0
    var paxPageCustomView : PaxPageCustomView?
    var paxPageCounterDelegate : PaxPageCounterDelegate?
    @IBOutlet weak var imageUserName: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.checkBoxView.checkBoxViewDelegate = self
        self.imageUserName.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension PaxPageTableViewCell : CheckBoxViewDelegate {
    func checkBoxTapped(isremember: Bool) {
        print(isremember)
        if isremember == true {
            
            self.paxPageCounterDelegate?.checkboxCounter(checkCounter: isremember)
        }else if isremember == false {
            self.paxPageCounterDelegate?.checkboxCounter(checkCounter: isremember)
        }
    }
    
    
}


