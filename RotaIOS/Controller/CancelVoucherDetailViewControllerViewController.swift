//
//  CancelVoucherDetailViewControllerViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 26.08.2021.
//

import UIKit
import DropDown

class CancelVoucherDetailViewControllerViewController: UIViewController {
    @IBOutlet var viewCancelVoucherDetailView: CancelVoucherDetailView!
    var voucherDetailInCancelVoucherDetailPage : GetVoucherDetailResponseModel?
    var cancelRulesMenu = DropDown()
    var paymentTypeMenu = DropDown()
    var cancelRulesListIntRulesMenu : [String] = []
    var cancelRulesList : [GetCancelRulesResponseModel] = []
    var filteredCancelRuleList : [GetCancelRulesResponseModel] = []
    var cancelRuleId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cancalRulesRequestModel = GetCancelRulesRequestModel.init(saleId: voucherDetailInCancelVoucherDetailPage?.saleId ?? 0)
        NetworkManager.sendGetRequestArray(url: NetworkManager.BASEURL, endPoint:.GetMobilCancelRules , method: .get, parameters: cancalRulesRequestModel.requestPathString()) { (response : [GetCancelRulesResponseModel]) in
            if response.count > 0 {
                self.cancelRulesList = response
                for item in self.cancelRulesList {
                    self.cancelRulesListIntRulesMenu.append(item.text ?? "")
                }
                self.cancelRulesMenu.dataSource = self.cancelRulesListIntRulesMenu
                self.cancelRulesMenu.backgroundColor = UIColor.grayColor
                self.cancelRulesMenu.separatorColor = UIColor.gray
                self.cancelRulesMenu.textColor = .white
                self.cancelRulesMenu.anchorView = self.viewCancelVoucherDetailView.viewCancelReason
                self.cancelRulesMenu.topOffset = CGPoint(x: 0, y:-(self.cancelRulesMenu.anchorView?.plainView.bounds.height)!)
            }else {
                print("data has not recived")
            }
        }
        
        self.viewCancelVoucherDetailView.labelExcursionLabel.text = self.voucherDetailInCancelVoucherDetailPage?.tourName
        self.viewCancelVoucherDetailView.labelExcursionDate.text = self.voucherDetailInCancelVoucherDetailPage?.tourDate
        self.viewCancelVoucherDetailView.labelReservationNo.text = self.voucherDetailInCancelVoucherDetailPage?.pax_ResNo
        self.viewCancelVoucherDetailView.labelSaleDate.text = self.voucherDetailInCancelVoucherDetailPage?.saleDate
        self.viewCancelVoucherDetailView.labelResNo.text = self.voucherDetailInCancelVoucherDetailPage?.pax_ResNo
        self.viewCancelVoucherDetailView.labelTourist.text = self.voucherDetailInCancelVoucherDetailPage?.tourist
        self.viewCancelVoucherDetailView.labelTourOperator.text = self.voucherDetailInCancelVoucherDetailPage?.operatorName
        self.viewCancelVoucherDetailView.labelHotel.text = self.voucherDetailInCancelVoucherDetailPage?.hotelName
        self.viewCancelVoucherDetailView.labelPayment.text = "\(self.voucherDetailInCancelVoucherDetailPage?.totalAmount ?? 0) \(self.voucherDetailInCancelVoucherDetailPage?.currencyDesc ?? "")"
        self.cancelRulesMenu.selectionAction = { index, title in
            self.viewCancelVoucherDetailView.viewCancelReason.mainLabel.text = title
            let filtered = self.cancelRulesList.filter{($0.text?.contains(title) ?? false)}
            self.filteredCancelRuleList = filtered
            for item in self.filteredCancelRuleList {
                self.cancelRuleId = item.value ?? 0
            }
            let cancalCalculateFeeRequestModel = GetCalculateCancelFeeRequestModel.init(cancelReasonId: self.cancelRuleId, saleId: self.voucherDetailInCancelVoucherDetailPage?.saleId ?? 0)
            NetworkManager.sendGetRequest(url: NetworkManager.BASEURL, endPoint: .GetCalculateCancelFee, method: .get, parameters: cancalCalculateFeeRequestModel.requestPathString()) { (response : GetCalculateCancelFeeResponseModel) in
                if response.amount != nil {
                    self.viewCancelVoucherDetailView.labelPayment.text = "\(response.amount ?? 0)"
                    self.viewCancelVoucherDetailView.labelRefund.text = "\(response.refundAmount ?? 0)"
                }else{
                    let alert = UIAlertController(title: "Error", message: "Data has not recived", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        let cancelRules = UITapGestureRecognizer(target: self, action: #selector(tappedCancelReason))
        self.viewCancelVoucherDetailView.viewCancelReason.addGestureRecognizer(cancelRules)
        
        let paymentTypeList = UITapGestureRecognizer(target: self, action: #selector(tappedPaymentTypeListMenu))
        self.viewCancelVoucherDetailView.viewPaymentType.addGestureRecognizer(paymentTypeList)
    }
    
    init(voucherDetailInCancelVoucherDetailPage : GetVoucherDetailResponseModel ) {
        self.voucherDetailInCancelVoucherDetailPage = voucherDetailInCancelVoucherDetailPage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedCancelReason() {
        self.cancelRulesMenu.show()
 
    }
    
    @objc func tappedPaymentTypeListMenu() {
        self.paymentTypeMenu.show()
    }
    @IBAction func cancelVoucherButtonClicked(_ sender: Any) {
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetPaymentTypes, method: .get, parameters: "") { (response : [GetPaymentTypeResponseModel] ) in
            
            if response.count > 0 {
                print(response)
                
            }else{
                print("data has not recived")
            }
        }
    }
}

