//
//  ZReportLoginViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 7.11.2021.
//

import UIKit

class ZReportLoginViewController: UIViewController {
    @IBOutlet var viewZReportLoginView: ZReportLoginView!
    var userName = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        self.userName = self.viewZReportLoginView.textUserName.text ?? ""
        self.password = self.viewZReportLoginView.textPassword.text ?? ""
        
        let getCreateZReportRequestModel = GetCreateZReportRequestModel.init(username: self.userName, password: self.password, guideRegistrationNumber: userDefaultsData.geUserNAme())
        NetworkManager.sendGetRequest(url: NetworkManager.BASEURL, endPoint:.GetCreateZReportPreview, method: .get, parameters: getCreateZReportRequestModel.requestPathString()) { (response : GetCreateZReportResponseModel) in
            if response.isSuccesful == true {
                let alert = UIAlertController(title: "SUCCESS", message: response.message ?? "", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.viewZReportLoginView.buttonLogin.isEnabled = false
            }else if response.isSuccesful == false {
                let alert = UIAlertController(title: "FALSE", message:  response.message ?? "" , preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "ERROR", message:  "Data Has not sent", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
}
