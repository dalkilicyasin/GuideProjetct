//
//  ZReportPreviewViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 5.11.2021.
//

import UIKit

class ZReportPreviewViewController: UIViewController {
    @IBOutlet var viewZreportPreview: ZReportPreviewViewView!
    @IBOutlet weak var tableView: UITableView!
    var zReportPreviewData : GetZReportPreviewResponseModel?
    var zReportPreview : [ReportPreview] = []
    var zReportTotal : [ReportTotal] = []
    var zReportRefund : [TourRefund] = []
    let date = Date()
    var dateString = ""
    var tempReportPreview : [String] = ["-","-","-","-","-","-"]
    var tempReportTotal : [String] = ["-","-","-"]
    var tempReportRefund : [String] = ["-","-","-","-"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let df = DateFormatter()
        df.dateFormat = "MM-dd-yyyy"
        self.dateString = df.string(from: date)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ZReportTotalTableViewCell.nib, forCellReuseIdentifier: ZReportTotalTableViewCell.identifier)
        self.tableView.register(ZReportPriviewTableViewCell.nib, forCellReuseIdentifier: ZReportPriviewTableViewCell.identifier)
        self.tableView.register(DailyReportTableViewCell.nib, forCellReuseIdentifier: DailyReportTableViewCell.identifier)
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        let getDailyReportRequestModel = GetZReportPreviewRequestModel.init(guideId: String(userDefaultsData.getGuideId()), date: dateString, guideRegistrationNumber: userDefaultsData.geUserNAme())
        NetworkManager.sendGetRequest(url: NetworkManager.BASEURL, endPoint:.GetZReportPreview, method: .get, parameters: getDailyReportRequestModel.requestPathString()) { (response : GetZReportPreviewResponseModel) in
            if response.guide != "" {
                self.zReportPreviewData = response
                self.zReportPreview = response.reportPreview ?? self.zReportPreview
                self.zReportTotal = response.reportTotal ?? self.zReportTotal
                self.zReportRefund = response.tourRefund ?? self.zReportRefund
                self.tableView.reloadData()
            }else {
                let alert = UIAlertController(title: "Error", message: "Data Has not Recived", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func printButtonClicked(_ sender: Any) {
        self.otiPushViewController(viewController: ZReportLoginViewController())
    }
}

extension ZReportPreviewViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if self.zReportPreview.count > 0 {
                return self.zReportPreview.count
            }
            return 1
        }else if section == 1{
            if self.zReportTotal.count > 0 {
                return self.zReportTotal.count
            }
            return 1
        }else {
            if self.zReportRefund.count > 0 {
                return self.zReportRefund.count
            }
            return 1
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "ZReport Preview"
        }else if section == 1 {
            return "ZReport Total"
        }else {
            return "ZReport Refund"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.font = UIFont.init(name: "Montserrat-Regular", size: 14)
        header?.textLabel?.textColor = .black
        // header?.backgroundView?.backgroundColor = UIColor.grayColor
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ZReportPriviewTableViewCell.identifier) as! ZReportPriviewTableViewCell
            if self.zReportPreview.count > 0 {
                cell.labelType.text = self.zReportPreview[indexPath.row].saleType
                cell.labelPaymentType.text = self.zReportPreview[indexPath.row].paymentType
                cell.labelSale.text = self.zReportPreview[indexPath.row].saleAmount
                cell.labelRefund.text = self.zReportPreview[indexPath.row].refundAmount
                cell.labelTotal.text = self.zReportPreview[indexPath.row].balanceAmount
                cell.labelCurrency.text = self.zReportPreview[indexPath.row].currencyType
                return cell
            }else {
                cell.labelType.text = self.tempReportPreview[indexPath.row]
                cell.labelPaymentType.text = self.tempReportPreview[indexPath.row]
                cell.labelSale.text = self.tempReportPreview[indexPath.row]
                cell.labelRefund.text = self.tempReportPreview[indexPath.row]
                cell.labelTotal.text = self.tempReportPreview[indexPath.row]
                cell.labelCurrency.text = self.tempReportPreview[indexPath.row]
                return cell
            }
        }else if indexPath.section == 1{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ZReportTotalTableViewCell.identifier) as! ZReportTotalTableViewCell
            if self.zReportTotal.count > 0 {
                cell.labelPaymentType.text = self.zReportTotal[indexPath.row].paymentType
                cell.labelAmount.text = self.zReportTotal[indexPath.row].amount
                cell.labelCurrencyType.text = self.zReportTotal[indexPath.row].currencyType
                return cell
            }else {
                cell.labelPaymentType.text = self.tempReportTotal[indexPath.row]
                cell.labelAmount.text = self.tempReportTotal[indexPath.row]
                cell.labelCurrencyType.text = self.tempReportTotal[indexPath.row]
                return cell
            }
        } else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: DailyReportTableViewCell.identifier) as! DailyReportTableViewCell
            if self.zReportRefund.count > 0 {
                cell.labelPaymentType.text = self.zReportRefund[indexPath.row].paymentType
                cell.labelRefund.text = self.zReportRefund[indexPath.row].refundTypeDesc
                cell.labelAmount.text = self.zReportRefund[indexPath.row].refundAmount
                cell.labelCurrencyType.text = self.zReportRefund[indexPath.row].currencyType
                return cell
            }else {
                cell.labelPaymentType.text = self.tempReportRefund[indexPath.row]
                cell.labelRefund.text = self.tempReportRefund[indexPath.row]
                cell.labelAmount.text = self.tempReportRefund[indexPath.row]
                cell.labelCurrencyType.text = self.tempReportRefund[indexPath.row]
                return cell
            }
        }
    }
}


