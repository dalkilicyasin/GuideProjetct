//
//  ZReportPriviewTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 22.09.2021.
//

import UIKit

class ZReportPriviewTableViewCell: BaseTableViewCell {
    @IBOutlet weak var viewDetailContentView: UIView!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelPaymentType: UILabel!
    @IBOutlet weak var labelSale: UILabel!
    @IBOutlet weak var labelRefund: UILabel!
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var labelCurrency: UILabel!
    @IBOutlet weak var viewContentView: UIView!
    
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

    }
}
