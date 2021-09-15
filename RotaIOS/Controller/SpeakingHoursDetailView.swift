//
//  SpeakingHoursDetailView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 15.09.2021.
//

import Foundation
import UIKit

final class SpeakingHoursDetailView : UIView {
    @IBOutlet weak var viewHeaderDetailView: HeaderDetailCustomView!
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        self.viewHeaderDetailView.labelHeaderDetailView.text = "Speaking Hours"
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

