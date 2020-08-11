//
//  RegeditViewController.swift
//  Main
//
//  Created by adam on 2020/7/25.
//  Copyright © 2020 awesome. All rights reserved.
//

import UIKit
import iPush
import iMApi
import cableUi

class RegeditViewController: CUIBaseViewController {
    
    @IBOutlet weak var txUserName:UITextField!
    @IBOutlet weak var txPassword:UITextField!
    @IBOutlet weak var txNickName:UITextField!
    
    @IBAction func onRegister(){
        guard let userName:String = txUserName.text, userName.count > 0 else{
            return
        }
        guard let password:String = txPassword.text, userName.count > 0 else{
            return
        }
        guard let nickName:String = txNickName.text, userName.count > 0 else{
            return
        }
        self.showLoading()
        IMDemoService.getInstance().register(userName: userName, password: password, nickName: nickName) { (response:PHResponse<UserInfo>) in
            self.dismissLoading()
            if response.isSuccess == false{
                if let msg:String = response.msg {
                    self.showToast(msg:msg)
                }
            }else{
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

}
