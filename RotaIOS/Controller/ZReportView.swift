//
//  ZReportView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 20.09.2021.
//

import Foundation
import UIKit

final class ZReportView : UIView {
    @IBOutlet weak var viewHeaderDetailView: HeaderDetailCustomView!
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var viewDateView: MainTextCustomView!
    @IBOutlet weak var viewZreportNumberView: MainTextCustomView!
    @IBOutlet weak var buttonSearchButton: UIButton!
    
override func awakeFromNib() {
    self.viewHeaderDetailView.labelHeaderDetailView.text = "Z Report"
    self.viewContentView.layer.cornerRadius = 10
    self.viewContentView.backgroundColor = UIColor.grayColor
    self.viewDateView.headerLAbel.text = "Z Report Date"
    self.viewDateView.mainText.isHidden = false
    self.viewDateView.mainLabel.isHidden = true
    self.viewDateView.imageMainText.isHidden = true
    self.viewZreportNumberView.headerLAbel.text = "Z Report No"
    self.viewZreportNumberView.mainText.isHidden = false
    self.viewZreportNumberView.mainLabel.isHidden = true
    self.viewZreportNumberView.imageMainText.isHidden = true
    self.buttonSearchButton.layer.cornerRadius = 10
    self.buttonSearchButton.backgroundColor = UIColor.greenColor
    
}

required init(customParamArg: String) {
    super.init(frame: .zero)
}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
}
}
