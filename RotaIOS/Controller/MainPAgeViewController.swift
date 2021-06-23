//
//  MainPAgeViewController.swift
//  Rota
//
//  Created by Yasin Dalkilic on 17.04.2021.
//

import UIKit

class MainPAgeViewController: BaseViewController {


    @IBOutlet var mainPageView: MainPageView!
    let date = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        let df = DateFormatter()
        df.dateFormat = "MM-dd-yyyy"
        let dateString = df.string(from: date)
        
        print(dateString)
        
        NetworkManager.sendGetRequest(url:NetworkManager.BASEURL, endPoint: .GetUser, method: .get, parameters: "") { (response : GetMyInfoResponseModel) in
            
            if response.id != nil {
                print("info recived - \(response.id ?? "")")
        
                userDefaultsData.saveUserId(languageId: response.id ?? "default")
                userDefaultsData.saveGuideId(languageId: response.guideId!)
                userDefaultsData.saveSaleDate(saleDate: dateString)
            }else{
                let alert = UIAlertController(title: "Errror", message: "Token has not recived", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        let getGuideInfRequestModel =  GetGuideInfoRequestModel( id : userDefaultsData.getGuideId())
        
        NetworkManager.sendGetRequest(url:NetworkManager.BASEURL, endPoint: .GetGuideInfo, method: .get, parameters: getGuideInfRequestModel.requestPathString()) { (response : GetGuideInfoResponseModel) in
            
            if response.marketGroupId != nil {
    
                userDefaultsData.saveMarketGruopId(marketGroupId: response.marketGroupId ?? 0)
                
            }else{
                let alert = UIAlertController(title: "Errror", message: "Token has not recived", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.mainPageView.tableView.addObserver(self, forKeyPath:"contentSize", options: .new, context: nil)
        self.mainPageView.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.mainPageView.tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
           
                
                if let newValue = change?[.newKey] {
                    let newSize = newValue as! CGSize
                    self.mainPageView.tableViewHeigt.constant = newSize.height
                }
                
            
        }
        
    }

}
