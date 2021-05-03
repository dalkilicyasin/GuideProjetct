//
//  BaseMessageItem.swift
//  BaseProject
//
//  Created by Akif's Mac on 19.02.2019.
//  Copyright © 2019 OtiHolding. All rights reserved.
//

import ObjectMapper

public class BaseMessageItem:Mappable{
    
    public var type = ""
    public var code = 0
    public var message = ""
    public var stackTrace = ""
    
    
   public required init?(map: Map) {
        
    }
    
   public func mapping(map: Map) {
        type <- map["Type"]
        code <- map["Code"]
        message <- map["Message"]
        stackTrace <- map["StackTrace"]
    }
}

