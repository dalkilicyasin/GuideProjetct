//
//  MainPAgeViewController.swift
//  Rota
//
//  Created by Yasin Dalkilic on 17.04.2021.
//

import UIKit

class MainPAgeViewController: ViewController {

    @IBOutlet var mainPageView: MainPageView!
    let date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let df = DateFormatter()
        df.dateFormat = "MM-dd-yyyy"
        let dateString = df.string(from: date)
        
        print(dateString)
        
        
       // mainPageView.backgroundColor = UIColor.mainColor
        NetworkManager.sendGetRequest(url:NetworkManager.BASEURL, endPoint: .GetUser, method: .get, parameters: "") { (response : GetMyInfoResponseModel) in
            
            if response.id != nil {
                print("info recived - \(response.id ?? "")")
                print(response.guideId ?? "")
                
                userDefaultsData.saveUserId(languageId: response.id ?? "default")
                userDefaultsData.saveGuideId(languageId: response.guideId!)
                userDefaultsData.saveSaleDate(saleDate: dateString)
            }else{
                let alert = UIAlertController(title: "Errror", message: "Token has not recived", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }


 

}
