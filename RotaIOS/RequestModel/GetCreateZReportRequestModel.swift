//
//  GetCreateZReportRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 7.11.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetCreateZReportRequestModel : Mappable{
    public var username : String!
    public var password : String!
    public var guideRegistrationNumber : String!
    
    public required init?(map: Map) {
        
    }
    
    public init( username : String, password : String, guideRegistrationNumber : String) {
        self.username = username
        self.password = password
        self.guideRegistrationNumber = guideRegistrationNumber
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?guideRegistrationNumber=\(self.guideRegistrationNumber ?? "")&username=\(self.username ?? "")&password=\(self.password ?? "")"
    }
}
