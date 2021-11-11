//
//  ZReportMoreDetailViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 21.09.2021.
//

import UIKit

class ZReportMoreDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var viewZreportMoreDetailview: ZReportMoreDetailView!
    var zReportNumberInZReportDetailPage : String?
    var zReportData : GetReportDataResponseModel?
    var zReportPreview : [ReportPreview] = []
    var zReportTotal : [ReportTotal] = []
    var zReportRefund : [TourRefund] = []
    var tempReportPreview : [String] = ["-","-","-","-","-","-"]
    var tempReportTotal : [String] = ["-","-","-"]
    var tempReportRefund : [String] = ["-","-","-","-"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let getReportDataRequestModel = GetReportDataRequestModel.init(zReportNumber: self.zReportNumberInZReportDetailPage ?? "")
        NetworkManager.sendGetRequest(url: NetworkManager.BASEURL, endPoint:.GetZReportData, method: .get, parameters: getReportDataRequestModel.requestPathString()) { (response : GetReportDataResponseModel) in
            if response.zReportNo != nil {
                self.zReportData = response
                self.zReportPreview = response.reportPreview ?? self.zReportPreview
                self.zReportTotal = response.reportTotal ?? self.zReportTotal
                self.tableView.reloadData()
                self.viewZreportMoreDetailview.setConfigure(model: self.zReportData ?? GetReportDataResponseModel.init())
            }else {
                let alert = UIAlertController(title: "Error", message: "Data Has not Recived", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ZReportTotalTableViewCell.nib, forCellReuseIdentifier: ZReportTotalTableViewCell.identifier)
        self.tableView.register(ZReportPriviewTableViewCell.nib, forCellReuseIdentifier: ZReportPriviewTableViewCell.identifier)
        self.tableView.register(DailyReportTableViewCell.nib, forCellReuseIdentifier: DailyReportTableViewCell.identifier)
        self.tableView.register(HotelsandFlightsTableViewCell.nib, forCellReuseIdentifier: HotelsandFlightsTableViewCell.identifier)
    }
    
    @IBAction func printButtonClicked(_ sender: Any) {
    }
    
    init(zReportNumberInZReportDetailPage : String? ) {
        self.zReportNumberInZReportDetailPage = zReportNumberInZReportDetailPage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZReportMoreDetailViewController : UITableViewDelegate, UITableViewDataSource {
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
            return "ZReport Net Total"
        }else if section == 2 {
            return "ZReport Tour Refund Details"
        }else {
            return "Hotels and Flight Ticket"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.font = UIFont.init(name: "Montserrat-Regular", size: 14)
        header?.textLabel?.textColor = .black
        // header?.backgroundView?.backgroundColor = UIColor.grayColor
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
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
        } else if indexPath.section == 2{
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
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HotelsandFlightsTableViewCell.identifier) as! HotelsandFlightsTableViewCell
            return cell
        }
    }
}
