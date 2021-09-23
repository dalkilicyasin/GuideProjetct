//
//  ZReportMoreDetailView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 21.09.2021.
//

import Foundation
import UIKit

final class ZReportMoreDetailView : UIView {
    @IBOutlet weak var viewHeaderDetailView: HeaderDetailCustomView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var tableViewHeigt: NSLayoutConstraint!
    @IBOutlet weak var viewTopView: UIView!
    
    override func awakeFromNib() {
        self.viewHeaderDetailView.labelHeaderDetailView.text = "Z Report"
        self.viewTopView.roundCorners(.topLeft, radius: 10)
        self.viewTopView.roundCorners(.topRight, radius: 10)
        self.tableView.backgroundColor = UIColor.grayColor
        self.footerView.backgroundColor = UIColor.grayColor
        self.viewTopView.backgroundColor = UIColor.grayColor
        
    }
    
    func setConfigure( model : GetReportDataResponseModel) {
        
    }
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
