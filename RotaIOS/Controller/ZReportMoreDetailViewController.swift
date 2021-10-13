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
            return self.zReportPreview.count
        }else {
            return self.zReportTotal.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ZReportPriviewTableViewCell.identifier) as! ZReportPriviewTableViewCell
            cell.labelType.text = self.zReportPreview[indexPath.row].saleType
            cell.labelPaymentType.text = self.zReportPreview[indexPath.row].paymentType
            cell.labelSale.text = self.zReportPreview[indexPath.row].saleAmount
            cell.labelRefund.text = self.zReportPreview[indexPath.row].refundAmount
            cell.labelTotal.text = self.zReportPreview[indexPath.row].balanceAmount
            cell.labelCurrency.text = self.zReportPreview[indexPath.row].currencyType
            return cell
        }else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ZReportTotalTableViewCell.identifier) as! ZReportTotalTableViewCell
            cell.labelPaymentType.text = self.zReportTotal[indexPath.row].paymentType
            cell.labelAmount.text = self.zReportTotal[indexPath.row].amount
            cell.labelCurrencyType.text = self.zReportTotal[indexPath.row].currencyType
            return cell
        }
    }
}
