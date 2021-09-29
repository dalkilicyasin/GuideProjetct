//
//  ZReportLongClickMenu.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 26.09.2021.
//

import Foundation
import UIKit

class ZReportLongClickMenu : UIView {
    @IBOutlet var viewMainView: UIView!
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var viewRemoveView: UIView!
    @IBOutlet weak var buttonZReportPayments: UIButton!
    @IBOutlet weak var buttonZReportRefund: UIButton!
    @IBOutlet weak var buttonBackButton: UIButton!
    var zReportNumber : GetZReportResponseModel?
    var zreportPaymentList : [ZReportPaymentResponseModel] = []
    var zreportRefundList : [GetZreportRefundResponseModel] = []
    var zReportNo = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: ZReportLongClickMenu.self), owner: self, options: nil)
        self.viewMainView.addCustomContainerView(self)
        self.viewContentView.backgroundColor = UIColor.grayColor
        self.viewContentView.layer.cornerRadius = 10
        self.viewRemoveView.layer.cornerRadius = 5
        self.buttonZReportPayments.backgroundColor = UIColor.greenColor
        self.buttonZReportPayments.layer.cornerRadius = 10
        self.buttonZReportRefund.backgroundColor = UIColor.greenColor
        self.buttonZReportRefund.layer.cornerRadius = 10
        self.buttonBackButton.layer.cornerRadius = 10
        self.buttonBackButton.backgroundColor = UIColor.clear
        self.buttonBackButton.layer.borderWidth = 1
        self.buttonBackButton.layer.borderColor = UIColor.green.cgColor
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(removeView))
        self.viewRemoveView.addGestureRecognizer(gesture)
    }
    
    @objc func removeView() {
        self.removeFromSuperview()
    }
    
    @IBAction func zReportPaymentsButtonClicked(_ sender: Any) {
        if let topVC = UIApplication.getTopViewController() {
            let zReportPaymentsRequestModel = ZReportPaymentRequestModel.init(zReportNumber: String(self.zReportNo))
            NetworkManager.sendGetRequestArray(url: NetworkManager.BASEURL, endPoint:.GetZReportPayments , method: .get, parameters: zReportPaymentsRequestModel.requestPathString()) { (response : [ZReportPaymentResponseModel]) in
                if response.count > 0 {
                    self.zreportPaymentList = response
                    topVC.otiPushViewController(viewController: ZReportPaymentViewController.init(zReportPaymentList: self.zreportPaymentList), animated: true)
                }else {
                   print("error")
                }
            }
        }
    }
    
    @IBAction func zReportRefundButtonClicked(_ sender: Any) {
        if let topVC = UIApplication.getTopViewController() {
            let zReportRefundsRequestModel = GetZreportRefundRequestModel.init(zReportNumber: String(self.zReportNo))
            NetworkManager.sendGetRequestArray(url: NetworkManager.BASEURL, endPoint:.GetZReportRefunds , method: .get, parameters: zReportRefundsRequestModel.requestPathString()) { (response : [GetZreportRefundResponseModel]) in
                if response.count >= 0 {
                    self.zreportRefundList = response
                    topVC.otiPushViewController(viewController: ZReportRefundViewController.init(zReportRefundList: self.zreportRefundList), animated: true)
                }else {
                   print("error")
                }
            }
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.removeFromSuperview()
    }
}
