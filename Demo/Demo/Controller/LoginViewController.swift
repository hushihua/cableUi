//
//  LoginViewController.swift
//  Main
//
//  Created by adam on 2020/7/25.
//  Copyright © 2020 awesome. All rights reserved.
//

import UIKit
import iPush
import iMApi
import cableUi

class LoginViewController: CUIBaseViewController {
    
    @IBOutlet weak var txUserName:UITextField!
    @IBOutlet weak var txPassword:UITextField!
    
    @IBAction func onLogin(){
        guard let sUserName:String = txUserName.text, sUserName.count > 0 else{
            return
        }
        guard let sPassword:String = txPassword.text, sPassword.count > 0 else{
            return
        }
        self.showLoading()
        IMDemoService.getInstance().login(userName: sUserName, password: sPassword) { (response:PHResponse<UserInfo>) in
            if response.isSuccess == true, let info:UserInfo = response.data{
                UserDefaults.standard.set(sUserName, forKey: "UserName")
                UserDefaults.standard.set(sPassword, forKey: "Password")
                UserDefaults.standard.synchronize()
                guard let uid:String = info.imUid, let password:String = info.imPassword else{
                    self.dismissLoading()
                    return
                }
                self.imLogin(uid: uid, password: password)
            }else{
                self.dismissLoading()
            }
        }
    }
    
    func imLogin(uid: String, password: String){
        IMuiApi.getInstance().login(uid: uid, password: password) { (resp:PHResponse<CULoginResponse>) in
            self.dismissLoading()
            if resp.isSuccess == true{
                DispatchQueue.main.async {
                    if let controller:UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "Main"){
                        self.navigationController?.viewControllers = [controller]
                    }
                }
            }else{
                if let msg:String = resp.msg {
                    self.showToast(msg:msg)
                }
            }
        }
    }

}
