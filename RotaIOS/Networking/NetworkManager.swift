//
//  NetworkManager.swift
//  BaseProject
//
//  Created by Cüneyt AYVAZ on 2.07.2019.
//  Copyright © 2019 OtiHolding. All rights reserved.
//
import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

public class NetworkManager {
    
    public static var networkConnectionEnabled = true
    private static let TIMEOUT_INTERVAL: TimeInterval = 300
    public static var BASEURL = "https://rota-uat.odeontours.com"
    
    public static func sendRequest<T: Mappable>(url: String,endPoint: ServiceEndPoint, method: HTTPMethod = .post, requestModel: Mappable, indicatorEnabled: Bool = true,
                                         completion: @escaping(T) -> ()) {
        
        if !networkConnectionEnabled {
            return
        }
        
        guard let request = prepareRequest(url : url,endPoint: endPoint, method: method, requestModel: requestModel),
            let viewController = UIApplication.getTopViewController()
            else { return }
        
        if indicatorEnabled {
            viewController.showIndicator(tag: String(describing: request.self))
        }
        
        Alamofire.request(request).responseObject { (response: DataResponse<T>) in
            if indicatorEnabled {
                viewController.hideIndicator(tag: String(describing: request.self))
            }
            
            switch response.result {
            case .success(let responseModel):
                completion(responseModel)
                
            case .failure(let error as NSError):
                viewController.errorPopup(title: "Warning", message: "An error occurred when requesting", cancelButtonTitle: "OK")
                debugPrint(error.description)
            }
        }
    }
    
    public static func sendRequest<T: Mappable>(url : String,endPoint: ServiceEndPoint, method: HTTPMethod = .post, parameters: Parameters? = nil, indicatorEnabled: Bool = true,
                                         completion: @escaping(T) -> ()) {
        
        if !networkConnectionEnabled {
            return
        }
        
        guard let request = prepareRequest(url : url,endPoint: endPoint, method: method, parameters: parameters),
            let viewController = UIApplication.getTopViewController()
            else { return }
        
        if indicatorEnabled {
            viewController.showIndicator(tag: String(describing: request.self))
        }
        
        Alamofire.request(request).responseObject { (response: DataResponse<T>) in
            if indicatorEnabled {
                viewController.hideIndicator(tag: String(describing: request.self))
            }
            
            switch response.result {
            case .success(let responseModel):
                completion(responseModel)
                
            case .failure(let error as NSError):
                viewController.errorPopup(title: "Warning", message: "An error occurred when requesting", cancelButtonTitle: "OK")
                debugPrint(error.description)
            }
        }
    }
    
    private static func prepareRequest(url : String,endPoint: ServiceEndPoint, method: HTTPMethod, requestModel: Mappable) -> URLRequest? {
        let urlPath = url + endPoint.rawValue
        
        var request = URLRequest(url: URL(string: urlPath)!)
        request.timeoutInterval = TIMEOUT_INTERVAL
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestModel.toJSON())
        request.setValue(String(userDefaultsData.getLanguageId()), forHTTPHeaderField: "Language")
        
        return request
    }
    
    private static func prepareRequest(url: String,endPoint: ServiceEndPoint, method: HTTPMethod, parameters: Parameters? = nil) -> URLRequest? {
        let urlPath = url + endPoint.rawValue
        
        var request = URLRequest(url: URL(string: urlPath)!)
        request.timeoutInterval = TIMEOUT_INTERVAL
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        
        if parameters != nil {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters!)
        }
        
        return request
    }
    
    public static func sendGetRequest<T: Mappable>(url:String,endPoint: ServiceEndPoint, method: HTTPMethod, parameters: String, indicatorEnabled: Bool = true,
                                                completion: @escaping(T) -> ()) {
            
            if !networkConnectionEnabled {
                return
            }
            
            var urlPath = url + endPoint.rawValue
            if !parameters.elementsEqual("") {
                urlPath.append(parameters)
            }
            urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            var requestModel = URLRequest(url: URL(string: urlPath)!)
            requestModel.timeoutInterval = TIMEOUT_INTERVAL
            requestModel.setValue("application/json", forHTTPHeaderField: "Content-Type")
            requestModel.setValue("bearer \(baseData.getTokenResponse?.access_token ?? "")", forHTTPHeaderField: "Authorization")
            requestModel.httpMethod = method.rawValue

            
            let request = requestModel
            let viewController = UIApplication.getTopViewController()
            
            
            if indicatorEnabled {
                viewController!.showIndicator(tag: String(describing: request.self))
            }
        
            Alamofire.request(request).responseObject { (response: DataResponse<T>) in
                if indicatorEnabled {
                    viewController!.hideIndicator(tag: String(describing: request.self))
                }

                switch response.result {
                case .success(let responseModel):
                    completion(responseModel)

                case .failure(let error as NSError):
                    viewController!.errorPopup(title: "Warning", message: "An error occurred when requesting", cancelButtonTitle: "OK")
                    debugPrint(error.description)
                }
            }
        
        }
    
    public static func sendGetRequestArray<T: Mappable>(url:String,endPoint: ServiceEndPoint, method: HTTPMethod, parameters: String, indicatorEnabled: Bool = true,
                                                completion: @escaping([T]) -> ()) {
            
            if !networkConnectionEnabled {
                return
            }
            
            var urlPath = url + endPoint.rawValue
            if !parameters.elementsEqual("") {
                urlPath.append(parameters)
            }
            urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            var requestModel = URLRequest(url: URL(string: urlPath)!)
            requestModel.timeoutInterval = TIMEOUT_INTERVAL
            requestModel.setValue("application/json", forHTTPHeaderField: "Content-Type")
            requestModel.setValue("bearer \(baseData.getTokenResponse?.access_token ?? "")", forHTTPHeaderField: "Authorization")
            requestModel.httpMethod = method.rawValue
            
            let request = requestModel
            let viewController = UIApplication.getTopViewController()
            
            
            if indicatorEnabled {
                viewController!.showIndicator(tag: String(describing: request.self))
            }
        
        Alamofire.request(request).responseArray { (response: DataResponse<[T]>) in
            if indicatorEnabled {
                viewController!.hideIndicator(tag: String(describing: request.self))
            }
            
            switch response.result {
            case .success(let responseModel):
                completion(responseModel)
                
            case .failure(let error as NSError):
                viewController!.errorPopup(title: "Warning", message: "An error occurred when requesting", cancelButtonTitle: "OK")
                debugPrint(error.description)
            }
        }
    }
}
