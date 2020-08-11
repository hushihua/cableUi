//
//  UserInfo.swift
//  Main
//
//  Created by adam on 2020/7/23.
//  Copyright © 2020 awesome. All rights reserved.
//

import UIKit
import iPush

class UserInfo: NSObject {
    
    var uid:String?
    var userName:String?
    var password:String?
    var nickName:String?
    
    var imUid:String?
    var imPassword:String?
    
    public static func parseToObject(_ dict:[String:Any]) -> UserInfo{
        let info:UserInfo = UserInfo()
        
        let userInfo:[String:Any] = try! JSONTranslater.toDictionary(any: dict["userinfo"])
        info.uid = try! JSONTranslater.toString(any: userInfo["uid"])
        info.userName = try! JSONTranslater.toString(any: userInfo["username"])
        info.password = try! JSONTranslater.toString(any: userInfo["password"])
        info.nickName = try! JSONTranslater.toString(any: userInfo["nickname"])
        
        let imInfo:[String:Any] = try! JSONTranslater.toDictionary(any: dict["im_sdk"])
        info.imUid = try! JSONTranslater.toString(any: imInfo["uid"])
        info.imPassword = try! JSONTranslater.toString(any: imInfo["password"])
        return info
    }

}
