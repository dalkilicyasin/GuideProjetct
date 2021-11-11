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
    @IBOutlet weak var labelZreportNo: UILabel!
    @IBOutlet weak var laelReportDate: UILabel!
    @IBOutlet weak var labelGuideName: UILabel!
    @IBOutlet weak var labelCollector: UILabel!
    @IBOutlet weak var labelCreatedBy: UILabel!
    @IBOutlet weak var buttonPrintButton: UIButton!
    
    override func awakeFromNib() {
        self.viewHeaderDetailView.labelHeaderDetailView.text = "Z Report"
       /* self.viewTopView.roundCorners(.topLeft, radius: 10)
        self.viewTopView.roundCorners(.topRight, radius: 10)*/
        self.viewTopView.clipsToBounds = true
        self.viewTopView.layer.cornerRadius = 10
        self.viewTopView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tableView.backgroundColor = UIColor.grayColor
        self.footerView.backgroundColor = UIColor.grayColor
        self.viewTopView.backgroundColor = UIColor.grayColor
        self.buttonPrintButton.layer.cornerRadius = 10
        self.buttonPrintButton.backgroundColor = UIColor.greenColor
    }
    
    func setConfigure( model : GetReportDataResponseModel) {
        self.labelZreportNo.text = model.zReportNo
        self.laelReportDate.text = model.reportDateTime
        self.labelGuideName.text = model.guide
        self.labelCollector.text = model.collector
        self.labelCreatedBy.text = model.createdUser
    }
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
