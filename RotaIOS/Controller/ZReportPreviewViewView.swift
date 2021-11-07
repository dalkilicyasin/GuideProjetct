//
//  ZReportPreviewViewView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 5.11.2021.
//
import Foundation
import UIKit

final class ZReportPreviewViewView : UIView {
    @IBOutlet weak var viewHeaderDetailView: HeaderDetailCustomView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var buttonPrint: UIButton!
    @IBOutlet weak var viewContentView: UIView!
    
    override func awakeFromNib() {
        self.viewHeaderDetailView.labelHeaderDetailView.text = "Z Report Preview"
        self.tableView.backgroundColor = UIColor.grayColor
        self.tableView.layer.cornerRadius = 10
        self.buttonSearch.layer.cornerRadius = 10
        self.buttonPrint.layer.cornerRadius = 10
        self.buttonSearch.backgroundColor = UIColor.greenColor
        self.buttonPrint.backgroundColor = UIColor.greenColor
        self.viewContentView.backgroundColor = UIColor.grayColor
        self.viewContentView.layer.cornerRadius = 10
        UITableViewHeaderFooterView.appearance().tintColor = .gray
    }
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
