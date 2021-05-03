//
//  CreateTokenRequestModel.swift
//  Rota
//
//  Created by Yasin Dalkilic on 1.04.2021.
//

import UIKit
import ObjectMapper

public class CreateTokenRequestModel:Mappable{
    
    public var userName:String!
    public var password:String!
    public var languageID:Int!
    public var mobileInformation:String!
 
    public required init?(map: Map) {
        
    }
    
    public init() {
        self.userName = "0"
        self.password = "0"
        self.languageID = 1
        self.mobileInformation = UIDevice.current.modelName
    }
    
    
    public func mapping(map: Map) {
        userName <- map["UserName"]
        password <- map["Password"]
        languageID <- map["LanguageId"]
        mobileInformation <- map["MobilInformation"]
    }
}



