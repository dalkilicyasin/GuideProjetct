//
//  CancelVoucherViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 25.08.2021.
//

import UIKit

class CancelVoucherViewController: UIViewController {
    @IBOutlet var viewCancelVoucherView: CancelVoucherView!
    var voucherDetail : GetVoucherDetailResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        let voucherDetailRequestModel = GetVoucherDetailRequestModel.init(Voucher: self.viewCancelVoucherView.viewVoucherNo.mainText.text ?? "")
        NetworkManager.sendGetRequest(url: NetworkManager.BASEURL, endPoint: .GetVoucherDetail, method: .get, parameters: voucherDetailRequestModel.requestPathString()) { (response : GetVoucherDetailResponseModel) in
            if response.saleId != nil {
                self.voucherDetail = response
                self.otiPushViewController(viewController: CancelVoucherDetailViewControllerViewController(voucherDetailInCancelVoucherDetailPage: self.voucherDetail!), animated: true)
            }else{
                let alert = UIAlertController(title: "Error", message: "Data has not recived", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
