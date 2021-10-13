//
//  DailyReportTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.10.2021.
//

import UIKit

class DailyReportTableViewCell: BaseTableViewCell {
    @IBOutlet weak var viewDetailContentView: UIView!
    @IBOutlet weak var labelPaymentType: UILabel!
    @IBOutlet weak var labelRefund: UILabel!
    @IBOutlet weak var labelAmount: UILabel!
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var labelCurrencyType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.viewDetailContentView.layer.cornerRadius = 10
        self.viewDetailContentView.backgroundColor = UIColor.mainTextColor
        self.viewContentView.addLine(position: .top, color: .black, width: 1.0)
        self.viewContentView.addLine(position: .bottom, color: .black, width: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
