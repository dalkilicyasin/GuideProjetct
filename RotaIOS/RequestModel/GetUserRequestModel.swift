//
//  GetUserRequestModel.swift
//  OdeonDynamics
//
//  Created by Akif Demirezen on 13.02.2021.
//  Copyright © 2021 Azure. All rights reserved.
//

import UIKit
import ObjectMapper

public class GetUserRequestModel:Mappable{
    
    public var userId:Int!
    
    public required init?(map: Map) {
        
    }
    
    public init(userId:Int) {
        self.userId = userId
    }
    
    public func mapping(map: Map) {
        userId <- map["UserId"]
    }
}
