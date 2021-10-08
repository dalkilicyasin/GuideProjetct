//
//  MainPageView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 17.04.2021.
//

import Foundation
import UIKit

final class MainPageView : UIView, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableViewHeigt: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    let imageList = ["operation","view","report"]
    let nameList = ["Operations","Views", "Reports"]
    let mainPageList = [["Tasks","Excursion Sale","Ind. Shop Appoinment","Cancel Voucher","Send Offline Sales"],["My Tour Sale","My Shopping Sales","Birthday","Speaking Hours","Documents","Announcement"],["Z Report","Daily Sale/Refund Report","Z Report Preview"]]
    var sectionData : [Int : [String]] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MainPageTableViewCell.nib, forCellReuseIdentifier: MainPageTableViewCell.identifier)
        self.viewHeader.applyGradient(colours: [UIColor(hexString: "#BFD732"), UIColor(hexString: "#3DB54A")])
        self.tableView.layer.cornerRadius = 10
        
    }
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90.0
    }
    
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: contentView.frame.size.width , height: 80))
        let imageView = MainPageCustomView()
        imageView.imageMainPage.image = UIImage(named: imageList[section])
        imageView.labelMainPage.text = nameList[section]
        header.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: header.frame.size.width, height: header.frame.size.height)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        if self.mainPageList[indexPath.section] == mainPageList[0] {
            if let topVC = UIApplication.getTopViewController() {
                var viewController: UIViewController = UIViewController()
                switch(indexPath.row) {
                case 0 :
                    viewController = TasksViewController()
                case 1 :
                    viewController = ExcursionSaleViewController()
                case 2 :
                    viewController = ShopAppointmentViewController()
                case 3 :
                    viewController = CancelVoucherViewController()
                case 4 :
                    viewController = OfflineSalesViewController()
                default :
                    print("selected")
                }
                topVC.otiPushViewController(viewController: viewController)
            }
        }else if self.mainPageList[indexPath.section] == mainPageList[1]{
            if let topVC = UIApplication.getTopViewController() {
                var viewController: UIViewController = UIViewController()
                switch(indexPath.row) {
                
                case 0 :
                    viewController = MyTourSalesViewController()
                case 1 :
                    viewController = MyShoppingSaleViewController()
                case 2 :
                    viewController = MyTourSaleViewController()
                case 3 :
                    viewController = SpeakingHoursViewController()
                case 4 :
                    viewController = DocumentsViewController()
                case 5 :
                    viewController = AnnoucmentsViewController()
                default :
                    print("selected")
                    
                }
                topVC.otiPushViewController(viewController: viewController)
            }
        }else {
            if let topVC = UIApplication.getTopViewController() {
                var viewController: UIViewController = UIViewController()
                switch(indexPath.row) {
                
                case 0 :
                    viewController = ZReportViewController()
                case 1 :
                    viewController = MyTourSaleViewController()
                case 2 :
                    viewController = MyTourSaleViewController()
                case 3 :
                    viewController = MyTourSaleViewController()
                case 4 :
                    viewController = MyTourSaleViewController()
                case 5 :
                    viewController = MyTourSaleViewController()
                default :
                    print("selected")
                    
                }
                topVC.otiPushViewController(viewController: viewController)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainPageList[section].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MainPageTableViewCell.identifier) as! MainPageTableViewCell
        cell.labelText.text = mainPageList[indexPath.section][indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainPageList.count
    }
}
