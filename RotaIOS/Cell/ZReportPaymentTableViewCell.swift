//
//  ZReportPaymentTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 28.09.2021.
//

import UIKit

class ZReportPaymentTableViewCell: BaseTableViewCell {
    @IBOutlet weak var viewDetailContentView: UIView!
    @IBOutlet weak var labelVoucherNo: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      //  self.viewDetailContentView.backgroundColor = UIColor.mainTextColor
       // self.viewDetailContentView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
