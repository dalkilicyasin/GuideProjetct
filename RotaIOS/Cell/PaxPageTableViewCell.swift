//
//  PaxPageTableViewCell.swift
//  Rota
//
//  Created by Yasin Dalkilic on 23.04.2021.
//

import UIKit

class PaxPageTableViewCell: BaseTableViewCell{

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var mainText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
