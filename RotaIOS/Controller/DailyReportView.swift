//
//  DailyReportView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.10.2021.
//
import Foundation
import UIKit

final class DailyReportView : UIView {
    @IBOutlet weak var viewHeaderDetailView: HeaderDetailCustomView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonSearchButton: UIButton!
    @IBOutlet weak var viewContentView: UIView!
    
    override func awakeFromNib() {
        self.viewHeaderDetailView.labelHeaderDetailView.text = "Daily Sale/Refund Report"
        self.tableView.backgroundColor = UIColor.grayColor
        self.tableView.layer.cornerRadius = 10
        self.viewContentView.backgroundColor = UIColor.grayColor
    }
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
