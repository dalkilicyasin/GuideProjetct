//
//  ZReportPaymentViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 28.09.2021.
//

import UIKit

class ZReportPaymentViewController: UIViewController {
    @IBOutlet var zReportPaymentView: ZReportPaymentView!
    @IBOutlet weak var tableview: UITableView!
    var zReportPaymentList : [ZReportPaymentResponseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(ZReportPaymentTableViewCell.nib, forCellReuseIdentifier: ZReportPaymentTableViewCell.identifier)
    }
    
    init(zReportPaymentList : [ZReportPaymentResponseModel] ) {
        self.zReportPaymentList = zReportPaymentList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZReportPaymentViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.zReportPaymentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: ZReportPaymentTableViewCell.identifier) as! ZReportPaymentTableViewCell
        cell.labelVoucherNo.text = self.zReportPaymentList[indexPath.row].voucherNo
        cell.labelDate.text = self.zReportPaymentList[indexPath.row].saleDate
        return cell
    }
}
