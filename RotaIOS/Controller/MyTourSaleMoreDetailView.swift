//
//  MyTourSaleMoreDetailView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 11.08.2021.
//

import Foundation
import UIKit

final class MyTourSaleMoreDetailView : UIView {
    @IBOutlet weak var viewHeaderDetailView: HeaderDetailCustomView!
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var labelExcursionName: UILabel!
    @IBOutlet weak var labelExcursionDate: UILabel!
    @IBOutlet weak var labelResevationNo: UILabel!
    @IBOutlet weak var labelHotelName: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelReelPax: UILabel!
    @IBOutlet weak var labelCollectionGuide: UILabel!
    @IBOutlet weak var labelExcursionGuide: UILabel!
    @IBOutlet weak var labelDeployingGuide: UILabel!
    @IBOutlet weak var labelCancelStaff: UILabel!
    @IBOutlet weak var labelCancelDate: UILabel!
    @IBOutlet weak var labelCancelNote: UILabel!
    @IBOutlet weak var labelCancelVoucher: UILabel!
    @IBOutlet weak var labelRefund: UILabel!
    @IBOutlet weak var labelTotalPayment: UILabel!
    
    override func awakeFromNib() {
        self.viewHeaderDetailView.labelHeaderDetailView.text = "My Tour Sale"
        self.viewContentView.layer.cornerRadius = 10
        self.viewContentView.backgroundColor = UIColor.black
    }
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }    
}
