//
//  MyTourSaleDetailPageView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 8.08.2021.
//

import Foundation
import UIKit

final class MyTourSaleDetailPageView : UIView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewHeaderDetail: HeaderDetailCustomView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewHeaderDetail.labelHeaderDetailView.text = "My Tour Sales"
        self.tableView.backgroundColor = UIColor.mainViewColor
        self.tableView.layer.cornerRadius = 10
    }
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
