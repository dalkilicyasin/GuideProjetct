//
//  MyTourSaleView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 5.08.2021.
//

import Foundation
import UIKit

final class MyTourSaleView : UIView {
    
    @IBOutlet weak var viewHeaderDetail: HeaderDetailCustomView!
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var viewTourSelect: MainTextCustomView!
    @IBOutlet weak var viewStatusSelect: MainTextCustomView!
    @IBOutlet weak var viewBeginDate: MainTextCustomView!
    @IBOutlet weak var viewEndDate: MainTextCustomView!
    @IBOutlet weak var viewSaleDate: MainTextCustomView!
    @IBOutlet weak var viewSaleEndDate: MainTextCustomView!
    @IBOutlet weak var viewVoucherNo: MainTextCustomView!
    @IBOutlet weak var buttonSearch: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewHeaderDetail.labelHeader.text = "My Tour Sale"
        self.viewContentView.layer.cornerRadius = 10
        self.viewContentView.backgroundColor = UIColor.grayColor
        self.buttonSearch.backgroundColor = UIColor.green
        self.buttonSearch.layer.cornerRadius = 10
        self.viewTourSelect.headerLAbel.text = "Tour"
        self.viewStatusSelect.headerLAbel.text = "Status"
        self.viewBeginDate.headerLAbel.text = "Begin Date"
        self.viewEndDate.headerLAbel.text = "End Date"
        self.viewSaleDate.headerLAbel.text = "Sale Date"
        self.viewSaleEndDate.headerLAbel.text = "Sale End Date"
        self.viewVoucherNo.headerLAbel.text = "Voucher No"
        self.viewBeginDate.imageMainText.isHidden = true
        self.viewEndDate.imageMainText.isHidden = true
        self.viewSaleDate.imageMainText.isHidden = true
        self.viewVoucherNo.imageMainText.isHidden = true
        self.viewSaleEndDate.imageMainText.isHidden = true
        self.viewBeginDate.mainLabel.isHidden = true
        self.viewEndDate.mainLabel.isHidden = true
        self.viewSaleDate.mainLabel.isHidden = true
        self.viewVoucherNo.mainLabel.isHidden = true
        self.viewSaleEndDate.mainLabel.isHidden = true
        self.viewBeginDate.mainText.isHidden = false
        self.viewEndDate.mainText.isHidden = false
        self.viewSaleDate.mainText.isHidden = false
        self.viewVoucherNo.mainText.isHidden = false
        self.viewSaleEndDate.mainText.isHidden = false
    }
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
