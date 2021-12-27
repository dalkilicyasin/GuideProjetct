//
//  GetMaxGuideVoucherNumberRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 27.12.2021.
//


import Foundation
import UIKit
import ObjectMapper

public class  GetMaxGuideVoucherNumberRequestModel : Mappable{
    public var guideId : Int!
    public var saleDate : String!
    
    public required init?(map: Map) {
        
    }
    
    public init( guideId : Int, saleDate : String) {
        self.guideId = guideId
        self.saleDate = saleDate
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?guideId=\(self.guideId ?? 0)&saleDate=\(self.saleDate ?? "")"
    }
}
