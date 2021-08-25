//
//  MyShoopingSaleDetailView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.08.2021.
//

import Foundation
import UIKit

final class MyShoopingSaleDetailView : UIView {
    @IBOutlet weak var viewHeaderDetailView: HeaderDetailCustomView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewHeaderDetailView.labelHeaderDetailView.text = "My Shopp Sales"
        self.tableView.layer.cornerRadius = 10
        self.tableView.backgroundColor = UIColor.grayColor
    }
 
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
