//
//  ZReportDetailViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 21.09.2021.
//

import UIKit

class ZReportDetailViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var zReportDetailListInZReportDetailPage : [GetZReportResponseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(ZReportTableViewCell.nib, forCellReuseIdentifier: ZReportTableViewCell.identifier)
        
    }
    
    init(zReportDetailListInZReportDetailPage : [GetZReportResponseModel] ) {
        self.zReportDetailListInZReportDetailPage = zReportDetailListInZReportDetailPage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZReportDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.zReportDetailListInZReportDetailPage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: ZReportTableViewCell.identifier) as! ZReportTableViewCell
        cell.labelGuideName.text = "\(zReportDetailListInZReportDetailPage[indexPath.row].guideRef ?? 0)"
       cell.labelZreportNo.text = "\(zReportDetailListInZReportDetailPage[indexPath.row].zReportNo ?? 0)"
        cell.labelZreportDay.text = zReportDetailListInZReportDetailPage[indexPath.row].reportCreateDate
        cell.labelCollectionStatus.text =  zReportDetailListInZReportDetailPage[indexPath.row].collectionStateDesc
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.otiPushViewController(viewController: ZReportMoreDetailViewController.init(zReportNumberInZReportDetailPage: "\(zReportDetailListInZReportDetailPage[indexPath.row].zReportNo ?? 0)"), animated: true)
    }
}
