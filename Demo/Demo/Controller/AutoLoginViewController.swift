//
//  AutoLoginViewController.swift
//  Main
//
//  Created by adam on 2020/7/25.
//  Copyright © 2020 awesome. All rights reserved.
//

import UIKit
import iPush
import iMApi
import cableUi

class AutoLoginViewController: CUIBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sUserName:String = UserDefaults.standard.value(forKey: "UserName") as? String ?? ""
        let sPassword:String = UserDefaults.standard.value(forKey: "Password") as? String ?? ""
        if sUserName.count == 0 || sPassword.count == 0{
            if let controller:UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController"){
                self.navigationController?.pushViewController(controller, animated: true)
            }
            return
        }
        self.showLoading()
        IMDemoService.getInstance().login(userName: sUserName, password: sPassword) { (response:PHResponse<UserInfo>) in
            if response.isSuccess == true, let info:UserInfo = response.data{
                if let uid:String = info.imUid, let password:String = info.imPassword{
                    IMuiApi.getInstance().login(uid: uid, password: password) { (resp:PHResponse<CULoginResponse>) in
                        self.dismissLoading()
                        if resp.isSuccess == true{
                            UserDefaults.standard.set(sUserName, forKey: "UserName")
                            UserDefaults.standard.set(sPassword, forKey: "Password")
                            UserDefaults.standard.synchronize()
                            DispatchQueue.main.async {
                                if let controller:UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "Main"){
                                    self.navigationController?.pushViewController(controller, animated: true)
                                }
                            }
                        }else{
                            if let msg:String = response.msg {
                                self.showToast(msg:msg)
                            }
                        }
                    }
                }else{
                    self.dismissLoading()
                }
            }else{
                self.dismissLoading()
            }
        }
    }

}
