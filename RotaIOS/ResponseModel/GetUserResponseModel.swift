//
//  GetUserResponseModel.swift
//  OdeonDynamics
//
//  Created by Akif Demirezen on 14.02.2021.
//  Copyright © 2021 Azure. All rights reserved.
//

import UIKit
import ObjectMapper

struct GetUserResponseModel : Mappable {
    var id : Int?
    var name : String?
    var surname : String?
    var emailAddress : String?
    var userName : String?
    var rolelist : [Rolelist]?
    var typelist : [Typelist]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        name <- map["Name"]
        surname <- map["Surname"]
        emailAddress <- map["EmailAddress"]
        userName <- map["UserName"]
        rolelist <- map["rolelist"]
        typelist <- map["typelist"]
    }
}
struct Rolelist : Mappable {
    var recordId : Int?
    var userId : Int?
    var view : Bool?
    var typeListId : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        recordId <- map["RecordId"]
        userId <- map["UserId"]
        view <- map["View"]
        typeListId <- map["TypeListId"]
    }

}
struct Typelist : Mappable {
    var id : Int?
    var typeName : String?
    var subTypeName : String?
    var subTypeId : Int?
    var iconImages : IconImages?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        typeName <- map["TypeName"]
        subTypeName <- map["SubTypeName"]
        subTypeId <- map["SubTypeId"]
        iconImages <- map["iconImages"]
    }
}
struct IconImages : Mappable {
    var id : Int?
    var image_Name : String?
    var image_Url : String?
    var image_Desc : String?
    var status : Bool?
    var insertedBy : String?
    var insertedDate : String?
    var modifiedBy : String?
    var modifiedDate : String?
    var typeListId : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["Id"]
        image_Name <- map["Image_Name"]
        image_Url <- map["Image_Url"]
        image_Desc <- map["Image_Desc"]
        status <- map["Status"]
        insertedBy <- map["InsertedBy"]
        insertedDate <- map["InsertedDate"]
        modifiedBy <- map["ModifiedBy"]
        modifiedDate <- map["ModifiedDate"]
        typeListId <- map["TypeListId"]
    }

}
