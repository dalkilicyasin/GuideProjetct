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
    var message = ""
    var paymenTypeList : [String] = ["CASH","CARD"]
    
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
        self.viewCancelVoucherDetailView.setConfigure(model: self.voucherDetailInCancelVoucherDetailPage ?? GetVoucherDetailResponseModel.init())
        
        self.cancelRulesMenu.selectionAction = { index, title in
            self.viewCancelVoucherDetailView.viewCancelReason.mainLabel.text = title
            let filtered = self.cancelRulesList.filter{($0.text?.contains(title) ?? false)}
            self.filteredCancelRuleList = filtered
            for item in self.filteredCancelRuleList {
                self.cancelRuleId = item.value ?? 0
            }
            self.paymentTypeMenu.selectionAction = { index, title in
                self.viewCancelVoucherDetailView.viewPaymentType.mainLabel.text = title
            }
            self.paymentTypeMenu.dataSource = self.paymenTypeList
            self.paymentTypeMenu.backgroundColor = UIColor.grayColor
            self.paymentTypeMenu.separatorColor = UIColor.gray
            self.paymentTypeMenu.textColor = .white
            self.paymentTypeMenu.anchorView = self.viewCancelVoucherDetailView.viewPaymentType
            self.paymentTypeMenu.topOffset = CGPoint(x: 0, y:-(self.paymentTypeMenu.anchorView?.plainView.bounds.height)!)

            let cancalCalculateFeeRequestModel = GetCalculateCancelFeeRequestModel.init(cancelReasonId: self.cancelRuleId, saleId: self.voucherDetailInCancelVoucherDetailPage?.saleId ?? 0)
            NetworkManager.sendGetRequest(url: NetworkManager.BASEURL, endPoint: .GetCalculateCancelFee, method: .get, parameters: cancalCalculateFeeRequestModel.requestPathString()) { (response : GetCalculateCancelFeeResponseModel) in
                if response.amount != nil {
                    self.viewCancelVoucherDetailView.labelCancelationFee.text = "\(response.amount ?? 0) EUR"
                    self.viewCancelVoucherDetailView.labelRefundAmount.text = "\(response.refundAmount ?? 0) EUR"
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
        let tourSaleRequestCancelMobile = GetTourSaleCancelMobileRequestModel.init(GuideId: String(userDefaultsData.getGuideId()) , CancelConditionId: String(self.cancelRuleId) , Note: "", ChangeVoucher: "", TourSaleId: String(self.viewCancelVoucherDetailView.saleId) , Amount: self.viewCancelVoucherDetailView.labelCancelationFee.text ?? "", CurrencyId: String(self.viewCancelVoucherDetailView.currencyId) , PaymentType: "CASH")
        NetworkManager.sendRequest(url: NetworkManager.BASEURL, endPoint: .GetTourSaleCancelMobile, requestModel: tourSaleRequestCancelMobile ) { (response: GetTourSaleCancelMobileResponseModel) in
            if response.IsSuccesful ?? false{
                self.message = response.Message ?? ""
                print(response.Message ?? "success")
                let alert = UIAlertController(title: "Cancel Voucher", message: "\(self.message)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }else{
                self.message = response.Message ?? ""
                let alert = UIAlertController(title: "Cancel Voucher", message: "\(self.message)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

