//
//  MyShoppinSaleDetailViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.08.2021.
//

import UIKit

class MyShoppinSaleDetailViewController: UIViewController {
    var shopSalesDetailListInDetailPage : [GetShoppingSaleResponseModel] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MyShopingSalesDetailTableViewCell.nib, forCellReuseIdentifier: MyShopingSalesDetailTableViewCell.identifier)
    }
    
    init(shopSalesDetailListInDetailPage : [GetShoppingSaleResponseModel] ) {
        self.shopSalesDetailListInDetailPage = shopSalesDetailListInDetailPage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyShoppinSaleDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shopSalesDetailListInDetailPage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyShopingSalesDetailTableViewCell.identifier) as! MyShopingSalesDetailTableViewCell
        cell.labelShopDate.text = shopSalesDetailListInDetailPage[indexPath.row].shopDateStr
        cell.labelTourName.text = shopSalesDetailListInDetailPage[indexPath.row].steps
        cell.labelHotelName.text = shopSalesDetailListInDetailPage[indexPath.row].hotel
        cell.labelOperatorNAme.text = shopSalesDetailListInDetailPage[indexPath.row].oprName
        cell.labelPickUpTime.text = shopSalesDetailListInDetailPage[indexPath.row].pickupTimeStr
        cell.labelRoom.text = shopSalesDetailListInDetailPage[indexPath.row].room
        cell.labelStatus.text = "Active"
        cell.labelTotalPax.text = shopSalesDetailListInDetailPage[indexPath.row].totalCount
        cell.labelPlates.text = shopSalesDetailListInDetailPage[indexPath.row].plates
        cell.labelNote.text = shopSalesDetailListInDetailPage[indexPath.row].note
        cell.labelShoppingGuideNote.text = shopSalesDetailListInDetailPage[indexPath.row].shoppingGuideNote
        cell.labelPaxes.text = shopSalesDetailListInDetailPage[indexPath.row].paxes
        return cell
    }
}
