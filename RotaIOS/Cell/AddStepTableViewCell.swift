//
//  AddStepTableViewCell.swift
//  Rota
//
//  Created by Yasin Dalkilic on 24.04.2021.
//

import UIKit

protocol TouchDelegate {
    func touchTapped( touch : [String])
}

class AddStepTableViewCell: BaseTableViewCell {

    @IBOutlet weak var checkBoxView: CheckBoxView!
    @IBOutlet weak var labelText: UILabel!
    var touchDelegate : TouchDelegate?
    var nameList :[String] = []
    var isCheckRemember = false
    var addStepCustomView : AddStepCustomView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
   
      
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
       
       
       // self.touchDelegate?.touchTapped(touch: self.nameList)
        
       // self.addStepCustomView?.sendInfoDelegate = self
    }
    


}


