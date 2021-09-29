//
//  ZReportRefundView.swift
//  RotaIOS

import Foundation
import UIKit

final class ZReportRefundView : UIView {
    @IBOutlet weak var viewHeaderDetailView: HeaderDetailCustomView!
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        self.viewHeaderDetailView.labelHeaderDetailView.text = "Z Report Refund"
        self.tableView.backgroundColor = UIColor.grayColor
        self.tableView.roundCorners(.topLeft, radius: 10)
        self.tableView.roundCorners(.topRight, radius: 10)
}
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
