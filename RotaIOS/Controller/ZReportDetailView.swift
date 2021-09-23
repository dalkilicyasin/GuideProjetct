//
//  ZReportDetailView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 21.09.2021.
//

import Foundation
import UIKit

final class ZReportDetailView : UIView {
    @IBOutlet weak var viewHeaderDetailView: HeaderDetailCustomView!
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        self.viewHeaderDetailView.labelHeaderDetailView.text = "Z Report"
        self.tableView.backgroundColor = UIColor.grayColor
        self.tableView.layer.cornerRadius = 10
    }
    
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
