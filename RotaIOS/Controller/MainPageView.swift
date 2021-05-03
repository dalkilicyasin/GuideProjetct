//
//  MainPageView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 17.04.2021.
//

import Foundation
import UIKit

final class MainPageView : UIView, UITableViewDelegate, UITableViewDataSource {
    
    
  
    @IBOutlet weak var headerCustomView: HeaderCustomView!
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    
    let imageList = ["operation","view","report"]
    let nameList = ["Operations","Views", "Reports"]
    let mainPageList = [["Tasks","Excursion Sale","Ind. Shop Appoinment","Cancel Voucher","Send Offline Sales"],["My Tour Sale","My Shopping Sales","Birthday","Speaking Hours","Documents","Announcement"],["Z Report","Daily Sale/Refund Report","Z Report Preview"]]
    
    var sectionData : [Int : [String]] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MainPageTableViewCell.nib, forCellReuseIdentifier: MainPageTableViewCell.identifier)
        
        self.contentView.layer.cornerRadius = 10
        self.headerCustomView.imageHeader.image = UIImage(named: "odeonicon")
        self.headerCustomView.labelheader.text = "Odeon Tours TR"
        
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
                    viewController = VoucherViewController()
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
                    viewController = MyTourSaleViewController()
                default :
                    print("selected")
                    
                }
                topVC.otiPushViewController(viewController: viewController)
            }
        }else {
            print("selected")
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
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainPageList.count
    }
    
}
