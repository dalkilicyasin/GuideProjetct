//
//  GetGuideMarketRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 3.05.2021.
//

import UIKit
import ObjectMapper

public class  GetGuideMarketRequestModel : Mappable{
    
    public var guideId : Int!
    
    public required init?(map: Map) {
        
    }
    
    public init(userId:Int) {
        self.guideId = userId
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        return "?guideId=\(self.guideId ?? 0)"
    }
    
}

