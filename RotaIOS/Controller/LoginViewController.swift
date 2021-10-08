//
//  LoginViewController.swift
//  Rota
//
//  Created by Yasin Dalkilic on 29.03.2021.
//

import Foundation

import UIKit

final class LoginViewController : BaseViewController {
    @IBOutlet var viewLogin: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
}
    @IBAction func buttonClicked(_ sender: Any) {
        let createTokenRequestModel = CreateTokenRequestModel.init()
        createTokenRequestModel.userName = viewLogin.textUsername.text
        createTokenRequestModel.password = viewLogin.textPassword.text
        NetworkManager.sendRequest(url: NetworkManager.BASEURL, endPoint: .CreateToken, requestModel: createTokenRequestModel) { (response: GetTokenResponseModel) in
            if response.access_token != nil {
                baseData.getTokenResponse = response
                print("token received - \(response.access_token ?? "")")
                self.otiPushViewController(viewController: MainPAgeViewController())
            }else{
                let alert = UIAlertController(title: "Error", message: "Invalid Username/Password.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
