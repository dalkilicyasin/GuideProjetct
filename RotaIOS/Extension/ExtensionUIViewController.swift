//
//  ExtensionUIViewController.swift
//  BaseProject
//
//  Created by Akif Demirezen on 3.07.2019.
//  Copyright © 2019 OtiHolding. All rights reserved.
//

import UIKit
import ObjectMapper

public var tagHash : [String:UIView]  = [String:UIView]()
public var tagAlertHash : [String:UIAlertController]  = [String:UIAlertController]()

var baseData:BaseData =  BaseData.shared

extension UIViewController {
    
    public func showIndicator(tag: String) {
        
        if tagHash[tag] != nil {
            return
        }
        
        let spinnerView = UIView.init(frame: UIScreen.main.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.3)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.view.addSubview(spinnerView)
        }
        tagHash[tag] = spinnerView
    }
    
    public func hideIndicator(tag: String) {
        DispatchQueue.main.async {
            tagHash[tag]?.removeFromSuperview()
            tagHash[tag] = nil
        }
    }
    
    public func errorPopup(title:String,message:String,cancelButtonTitle:String){
        errorPopup(title: title, message: message, cancelButtonTitle: cancelButtonTitle, okButtonTitle: "")
    }
    
    public func errorPopup(title:String,message:String,cancelButtonTitle:String,okButtonTitle:String){
        
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        
        if(!okButtonTitle.isEmpty){
            alert.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: nil))
        }
        alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    public func showAlertMsg(msg : String, finished: @escaping () -> Void){
        let alert = UIAlertController(title: "Message", message : msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                finished()
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    public func getBaseRequestData<T:Mappable> (data:T)-> BaseApiRequestBody<T>{
        let systemVersion = UIDevice.current.systemVersion
        let deviceModel = UIDevice.current.modelName
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        return BaseApiRequestBody.init(token: baseData.getTokenResponse?.access_token ?? "", languageId: userDefaultsData.getLanguageId(), mobilInformation: "\(userDefaultsData.getDeviceId() ?? "");\(deviceModel);iOS;\(systemVersion); Wifi; \(appVersion)",data: data)
    }
    
    public func getBaseRequestArrayData<T:Mappable> (dataArray:[T])-> BaseApiRequestBody<T>{
        let systemVersion = UIDevice.current.systemVersion
        let deviceModel = UIDevice.current.modelName
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let baseApiRequestBodyModel = BaseApiRequestBody.init(token: baseData.getTokenResponse?.access_token ?? "", languageId: userDefaultsData.getLanguageId(), mobilInformation: "\(deviceModel);iOS;\(systemVersion); Wifi; \(appVersion)", dataArray: dataArray)
        baseApiRequestBodyModel.dataArray = dataArray
        return baseApiRequestBodyModel
    }
    
    func otiPushViewController(identifier : String, animated: Bool = true) {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: identifier)
        self.otiPushViewController(viewController: viewController, animated: animated)
    }
    
    func otiPresentViewController(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        self.present(viewController, animated: animated, completion: completion)
    }
    
    func otiPushViewController(viewController: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
}


