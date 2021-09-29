//
//  ZReportRefundTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 29.09.2021.
//

import UIKit

class ZReportRefundTableViewCell: BaseTableViewCell {
    @IBOutlet weak var labelVoucherNo: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
