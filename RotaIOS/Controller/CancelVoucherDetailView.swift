//
//  CancelVoucherDetailViewControllerView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 26.08.2021.
//

import Foundation
import UIKit
import DropDown

final class CancelVoucherDetailView : UIView {
    @IBOutlet weak var viewHeaderDetailView: HeaderDetailCustomView!
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var viewContentDetail: UIView!
    @IBOutlet weak var viewFooterView: UIView!
    @IBOutlet weak var viewCancelReason: MainTextCustomView!
    @IBOutlet weak var viewPaymentType: MainTextCustomView!
    @IBOutlet weak var viewNoteMenu: MainTextCustomView!
    @IBOutlet weak var buttonCancelVoucherButton: UIButton!
    @IBOutlet weak var labelExcursionLabel: UILabel!
    @IBOutlet weak var labelExcursionDate: UILabel!
    @IBOutlet weak var labelReservationNo: UILabel!
    @IBOutlet weak var labelSaleDate: UILabel!
    @IBOutlet weak var labelResNo: UILabel!
    @IBOutlet weak var labelTourist: UILabel!
    @IBOutlet weak var labelTourOperator: UILabel!
    @IBOutlet weak var labelHotel: UILabel!
    @IBOutlet weak var labelPayment: UILabel!
    @IBOutlet weak var labelTotalPax: UILabel!
    @IBOutlet weak var labelCancelationFee: UILabel!
    @IBOutlet weak var labelRefundAmount: UILabel!
    @IBOutlet weak var labelCancelationDate: UILabel!
    @IBOutlet weak var labelVoucherNo: UILabel!
    var saleId = 0
    var currencyId = 0
    var paymentTypeMenu = DropDown()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewHeaderDetailView.labelHeaderDetailView.text = "Cancel Voucher"
        self.viewContentView.backgroundColor = UIColor.black
        self.viewContentView.layer.cornerRadius = 10
        self.viewContentDetail.layer.cornerRadius = 10
        self.viewFooterView.backgroundColor = UIColor.grayColor
        self.viewFooterView.layer.cornerRadius = 10
        self.viewCancelReason.headerLAbel.text = "Cancel Reason"
        self.viewPaymentType.headerLAbel.text = "Payment Type"
        self.buttonCancelVoucherButton.layer.cornerRadius = 10
        self.buttonCancelVoucherButton.backgroundColor = UIColor.greenColor
        self.viewNoteMenu.mainLabel.isHidden = true
        self.viewNoteMenu.imageMainText.isHidden = true
        self.viewNoteMenu.mainText.isHidden = false
        self.viewNoteMenu.headerLAbel.text = "Note"
        
       
    }
    
    func setConfigure(model : GetVoucherDetailResponseModel ) {
        self.labelExcursionLabel.text = model.tourName
        self.labelExcursionDate.text = model.tourDate
        self.labelReservationNo.text = model.pax_ResNo
        self.labelSaleDate.text = model.saleDate
        self.labelResNo.text = model.pax_ResNo
        self.labelTourist.text = model.tourist
        self.labelTourOperator.text = model.operatorName
        self.labelHotel.text = model.hotelName
        self.labelTotalPax.text = model.totalPax
        self.labelVoucherNo.text = model.voucherNo
        self.labelCancelationDate.text = model.cancelDate
        self.labelPayment.text = "\(model.totalAmount ?? 0) \(model.currencyDesc ?? "")"
        self.saleId = model.saleId ?? 0
        self.currencyId = model.currencyId ?? 0
    }
 
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
