//
//  DailyReportViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.10.2021.
//

import UIKit
import Foundation

class DailyReportViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var viewDailyReportView: DailyReportView!
    var dailyReportData : GetDailyReportResponseModel?
    var dailyReportPreview : [ReportPreview] = []
    var dailyReportTotal : [ReportTotal] = []
    var dailyReportRefund : [TourRefund] = []
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
        let getDailyReportRequestModel = GetDailyReportRequestModel.init(guideId: String(userDefaultsData.getGuideId()), date: dateString)
        NetworkManager.sendGetRequest(url: NetworkManager.BASEURL, endPoint:.GetGuideDailyReport, method: .get, parameters: getDailyReportRequestModel.requestPathString()) { (response : GetDailyReportResponseModel) in
            if response.guide != "" {
                self.dailyReportData = response
                self.dailyReportPreview = response.reportPreview ?? self.dailyReportPreview
                self.dailyReportTotal = response.reportTotal ?? self.dailyReportTotal
                self.dailyReportRefund = response.tourRefund ?? self.dailyReportRefund
                self.tableView.reloadData()
            }else {
                let alert = UIAlertController(title: "Error", message: "Data Has not Recived", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension DailyReportViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if self.dailyReportPreview.count > 0 {
                return self.dailyReportPreview.count
            }
            return 1
        }else if section == 1{
            if self.dailyReportTotal.count > 0 {
                return self.dailyReportTotal.count
            }
            return 1
        }else {
            if self.dailyReportRefund.count > 0 {
                return self.dailyReportRefund.count
            }
            return 1
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Daily Report Preview"
        }else if section == 1 {
            return "Daily Report Total"
        }else {
            return "Daily Report Refund"
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
            if self.dailyReportPreview.count > 0 {
                cell.labelType.text = self.dailyReportPreview[indexPath.row].saleType
                cell.labelPaymentType.text = self.dailyReportPreview[indexPath.row].paymentType
                cell.labelSale.text = self.dailyReportPreview[indexPath.row].saleAmount
                cell.labelRefund.text = self.dailyReportPreview[indexPath.row].refundAmount
                cell.labelTotal.text = self.dailyReportPreview[indexPath.row].balanceAmount
                cell.labelCurrency.text = self.dailyReportPreview[indexPath.row].currencyType
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
            if self.dailyReportTotal.count > 0 {
                cell.labelPaymentType.text = self.dailyReportTotal[indexPath.row].paymentType
                cell.labelAmount.text = self.dailyReportTotal[indexPath.row].amount
                cell.labelCurrencyType.text = self.dailyReportTotal[indexPath.row].currencyType
                return cell
            }else {
                cell.labelPaymentType.text = self.tempReportTotal[indexPath.row]
                cell.labelAmount.text = self.tempReportTotal[indexPath.row]
                cell.labelCurrencyType.text = self.tempReportTotal[indexPath.row]
                return cell
            }
        } else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: DailyReportTableViewCell.identifier) as! DailyReportTableViewCell
            if self.dailyReportRefund.count > 0 {
                cell.labelPaymentType.text = self.dailyReportRefund[indexPath.row].paymentType
                cell.labelRefund.text = self.dailyReportRefund[indexPath.row].refundTypeDesc
                cell.labelAmount.text = self.dailyReportRefund[indexPath.row].refundAmount
                cell.labelCurrencyType.text = self.dailyReportRefund[indexPath.row].currencyType
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
