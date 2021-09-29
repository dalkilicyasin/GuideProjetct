//
//  ZReportPaymentView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 28.09.2021.
//

import Foundation
import UIKit

final class ZReportPaymentView : UIView {
    @IBOutlet weak var viewHeaderDetailView: HeaderDetailCustomView!
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var vtableView: UITableView!
    
    override func awakeFromNib() {
        self.viewHeaderDetailView.labelHeaderDetailView.text = "Z Report Payments"
        self.viewContentView.backgroundColor = UIColor.grayColor
        self.viewContentView.layer.cornerRadius = 10
        self.vtableView.layer.cornerRadius = 10
        self.vtableView.backgroundColor = UIColor.clear
    }
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
