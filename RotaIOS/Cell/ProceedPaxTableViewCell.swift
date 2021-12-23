//
//  ProceedPaxTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 23.12.2021.
//

import UIKit

class ProceedPaxTableViewCell: BaseTableViewCell {
    @IBOutlet weak var labelPaymentType: UILabel!
    @IBOutlet weak var labelPaymentPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
