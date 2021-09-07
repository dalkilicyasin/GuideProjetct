//
//  CancelVoucherView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 25.08.2021.
//

import Foundation
import UIKit

final class CancelVoucherView : UIView {
    @IBOutlet weak var viewHeaderDetailCustomView: HeaderDetailCustomView!
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var viewVoucherNo: MainTextCustomView!
    @IBOutlet weak var buttonSearchButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewHeaderDetailCustomView.labelHeaderDetailView.text = "Cancel Voucher"
        self.viewContentView.backgroundColor = UIColor.grayColor
        self.viewContentView.layer.cornerRadius = 10
        self.viewVoucherNo.layer.cornerRadius = 10
        self.viewVoucherNo.headerLAbel.text = "Voucher No"
        self.viewVoucherNo.mainText.isHidden = false
        self.viewVoucherNo.mainLabel.isHidden = true
        self.viewVoucherNo.imageMainText.isHidden = true
        self.buttonSearchButton.backgroundColor = UIColor.greenColor
        self.buttonSearchButton.layer.cornerRadius = 10
    }
 
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
