//
//  GetTouristInfoRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 16.05.2021.
//


import Foundation
import UIKit
import ObjectMapper

public class  GetTouristInfoRequestModel : Mappable{
    
    public var touristId : Int!
    public var resNo : Int!
    
    public required init?(map: Map) {
        
    }
    
    public init(touristId: Int, resNo: Int) {
        self.touristId = touristId
        self.resNo = resNo
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?touristId=\(self.touristId ?? 0)&resNo=\(self.resNo ?? 0)"
    }
    
}

