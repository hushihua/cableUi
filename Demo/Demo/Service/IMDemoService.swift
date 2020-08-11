//
//  IMDemoService.swift
//  Main
//
//  Created by adam on 2020/7/23.
//  Copyright © 2020 awesome. All rights reserved.
//

import UIKit
import iPush

class IMDemoService: PHHttpClient {
    
    static let instance:IMDemoService = IMDemoService()
    public static func getInstance()-> IMDemoService{
        return instance
    }
    
    private final let REGISTER:String      = "/demo/register"              //用户登录
    private final let LOGIN:String         = "/demo/login"                  //验证码登录
    
    public func register(userName:String, password:String, nickName:String, handler:@escaping (PHResponse<UserInfo>) ->Void){
        var params:[String:String] = [:]
        params["username"] = userName
        params["password"] = password
        params["nickname"] = nickName
        self.requestPost(requestUrl: Constant.BASE_URL + REGISTER, params: params) { (result:PHResponse<Any>) in
            if result.isSuccess == true, let dictData = result.data as? [String:Any]{
                let data:[String:Any] = try! JSONTranslater.toDictionary(any: dictData["data"])
                let info:UserInfo =  UserInfo.parseToObject(data)
                handler(PHResponse<UserInfo>(data: info))
            }else{
                handler(PHResponse<UserInfo>(msg:result.msg))
            }
        }
    }
    
    public func login(userName:String, password:String, handler:@escaping (PHResponse<UserInfo>) ->Void){
        var params:[String:String] = [:]
        params["username"] = userName
        params["password"] = password
        self.requestPost(requestUrl: Constant.BASE_URL + LOGIN, params: params) { (result:PHResponse<Any>) in
            if result.isSuccess == true, let dictData = result.data as? [String:Any]{
                let data:[String:Any] = try! JSONTranslater.toDictionary(any: dictData["data"])
                let info:UserInfo =  UserInfo.parseToObject(data)
                handler(PHResponse<UserInfo>(data: info))
            }else{
                handler(PHResponse<UserInfo>(msg:result.msg))
            }
        }
    }

}
