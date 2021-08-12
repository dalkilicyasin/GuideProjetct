//
//  MyTourSaleDetailPageViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 8.08.2021.
//

import UIKit
import Foundation

class MyTourSaleDetailPageViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var viewMyTourSaleDetailPage: MyTourSaleDetailPageView!
    var tourDetailListInDetailPage : [GetTourDetailForMobileResponseModel] = []
    var tourDetailItem : GetTourDetailForMobileResponseModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.grayColor
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MyTourSalesDetailPageTableViewCell.nib, forCellReuseIdentifier: MyTourSalesDetailPageTableViewCell.identifier)
    }
    
    init(tourDetailListInDetailPage : [GetTourDetailForMobileResponseModel] ) {
        self.tourDetailListInDetailPage = tourDetailListInDetailPage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyTourSaleDetailPageViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tourDetailListInDetailPage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTourSalesDetailPageTableViewCell.identifier) as! MyTourSalesDetailPageTableViewCell
        self.tourDetailItem = self.tourDetailListInDetailPage[indexPath.row]
        cell.labelTourName.text = self.tourDetailItem?.tourName
        cell.labelTourDate.text = self.tourDetailItem?.tourDateStr
        cell.labelTourTime.text = self.tourDetailItem?.tourPickupTime
        cell.labelHotelName.text = self.tourDetailItem?.hotelName
        cell.labelReelPax.text = self.tourDetailItem?.totalPax
        cell.labelResNo.text = self.tourDetailItem?.pax_ResNo
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.otiPushViewController(viewController: MyTourSaleMoreDetailViewController(tourDetailListInMoreDetailPage: self.tourDetailListInDetailPage[indexPath.row]), animated: true)
    }
}


