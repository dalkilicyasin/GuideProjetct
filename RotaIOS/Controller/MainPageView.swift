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
    var oflineDataList : [String] = []
    var counter = 0
    var maxVoucherNo = ""
    var addedVoucher = ""
    var createVoucher = ""
    var offlineTourSalePostList : [TourSalePost] = []
    var tourList : [TourList] = []
    var maxVoucherIntAdeed = 0
    var voucherList : [String] = []
    
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
                    viewController = ExcursionViewController()
                case 2 :
                    viewController = ShopAppointmentViewController()
                case 3 :
                    viewController = CancelVoucherViewController()
                case 4 :
                    // Create VOucher
                    self.offlineTourSalePostList = userDefaultsData.getTourSalePost() ?? self.offlineTourSalePostList
                    if self.offlineTourSalePostList.count > 0 {
                        var shortyear = ""
                        let year =  Calendar.current.component(.year, from: Date())
                        shortyear = String(year)
                        shortyear = shortyear.replacingOccurrences(of: "20", with: "", options: String.CompareOptions.literal, range: nil)
                        print(shortyear)
                        let month = Calendar.current.component(.month, from: Date())
                        let day = Calendar.current.component(.day, from: Date())
                        let hour = Calendar.current.component(.hour, from: Date())
                        let minute = Calendar.current.component(.minute, from: Date())
                        
                        let mergeDate = String(format: "%02d%02d%02d%02d", month, day, hour, minute)
                        print(mergeDate)
                        
                        let getMaxVoucherRequestModel = GetMaxGuideVoucherNumberRequestModel(guideId: userDefaultsData.getGuideId(), saleDate: userDefaultsData.getSaleDate())
                     
                            NetworkManager.sendGetRequestInt(url: NetworkManager.BASEURL, endPoint: .GetMaxGuideVoucherNumber, method: .get, parameters: getMaxVoucherRequestModel.requestPathString()) { (response : Int) in
                                if response != 0 {
                                    self.counter = 0
                                    print(response)
                                    self.maxVoucherNo = String(response)
                                    let startIndex = self.maxVoucherNo.index(self.maxVoucherNo.startIndex, offsetBy: 3)
                                    let endIndex = self.maxVoucherNo.index(self.maxVoucherNo.startIndex, offsetBy: 4)
                                    self.maxVoucherNo = String(self.maxVoucherNo[startIndex...endIndex])
                                   
                                    if self.offlineTourSalePostList.count > 0 {
                                        for i in 0...self.offlineTourSalePostList.count - 1 {
                                
                                            self.tourList = self.offlineTourSalePostList[i].TourList ?? self.tourList
                                            
                                            for i in 0...self.tourList.count - 1 {
                                                self.createVoucher = ""
                                                self.counter = i + 1
                                                print(self.maxVoucherNo)
                                                if let maxVoucherInt = Int(self.maxVoucherNo) {
                                                    self.maxVoucherIntAdeed = maxVoucherInt
                                                    self.maxVoucherIntAdeed += self.counter
                                                }
                                                self.addedVoucher = String(format: "%02d", self.maxVoucherIntAdeed)
                                                if userDefaultsData.getDay() != day {
                                                    self.createVoucher = "\(userDefaultsData.geUserNAme() ?? "")\(shortyear)\(month)\(day)\(hour)\(minute)\(self.addedVoucher)"
                                                    userDefaultsData.saveDay(day: day)
                                                }else if userDefaultsData.getDay() == day {
                                                    self.counter = 1
                                                    self.createVoucher = "\(userDefaultsData.geUserNAme() ?? "")\(shortyear)\(mergeDate)\(self.addedVoucher)"
                                                    userDefaultsData.saveDay(day: day)
                                                }
                                                self.voucherList.append(self.createVoucher) // deneme için yapıldı silinecek
                                                print(self.voucherList) //
                                                
                                                self.tourList[i].VoucherNo = self.createVoucher
                                            }
                                            self.offlineTourSalePostList[i].TourList = self.tourList
                                        }
                                        
                                        for i in 0...self.offlineTourSalePostList.count - 1{
                                            let data = "\(self.offlineTourSalePostList[i].toJSONString(prettyPrint: true) ?? "")"
                                            self.oflineDataList.append(data)
                                        }
                                    }
                                   
                                    
                                    if self.oflineDataList.count > 0 {
                                        for i in 0...self.oflineDataList.count - 1 {
                                            let toursaleRequestModel = GetSaveMobileSaleRequestModel.init(data: self.oflineDataList[i])
                                            NetworkManager.sendRequest(url: NetworkManager.BASEURL, endPoint: .GetSaveMobileSale, requestModel: toursaleRequestModel ) { (response: GetSaveMobileSaleResponseModel) in
                                                if response.IsSuccesful == true {
                                                    print(response)
                                                    let alert = UIAlertController(title: "SUCCSESS", message: response.Message ?? "", preferredStyle: .alert)
                                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                                    if let topVC = UIApplication.getTopViewController() {
                                                        topVC.present(alert, animated: true, completion: nil)
                                                        self.offlineTourSalePostList.remove(at: i)
                                                        userDefaultsData.saveTourSalePost(tour: self.offlineTourSalePostList)
                                                    }
                                                    
                                                }else {
                                                    let alert = UIAlertController(title: "FAILED", message: response.Message ?? "", preferredStyle: .alert)
                                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                                    if let topVC = UIApplication.getTopViewController() {
                                                        topVC.present(alert, animated: true, completion: nil)
                                                        self.offlineTourSalePostList.remove(at: i)
                                                        userDefaultsData.saveTourSalePost(tour: self.offlineTourSalePostList)
                                                    }
                                                    
                                                }
                                            }
                                        }
                                        self.oflineDataList.removeAll()
                                    }
                                   
                                }else {
                                    print("error")
                                }
                            }
                        
                        return
                        //
                    }else {
                        let alert = UIAlertController.init(title: "WARNING", message: "No Offline Sales", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        if let topVC = UIApplication.getTopViewController(){
                            topVC.present(alert, animated: true, completion: nil)
                        }
                    }
                  
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
                    viewController = DailyReportViewController()
                case 2 :
                    viewController = ZReportPreviewViewController()
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
