//
//  ZReportRefundViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 29.09.2021.
//

import UIKit

class ZReportRefundViewController: UIViewController {
    @IBOutlet var zReportRefundView: ZReportRefundView!
    @IBOutlet weak var tableView: UITableView!
    var zReportRefundList : [GetZreportRefundResponseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ZReportRefundTableViewCell.nib, forCellReuseIdentifier: ZReportRefundTableViewCell.identifier)
    }
    
    init(zReportRefundList : [GetZreportRefundResponseModel] ) {
        self.zReportRefundList = zReportRefundList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ZReportRefundViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.zReportRefundList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZReportRefundTableViewCell.identifier) as! ZReportRefundTableViewCell
        cell.labelVoucherNo.text = self.zReportRefundList[indexPath.row].voucherNo
        cell.labelDate.text = self.zReportRefundList[indexPath.row].saleDate
        return cell
    }
}
