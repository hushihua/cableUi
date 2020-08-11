//
//  DemoSessionViewController.swift
//  Main
//
//  Created by adam on 2020/7/23.
//  Copyright © 2020 awesome. All rights reserved.
//

import UIKit
import cableUi
import iMApi
import iPush

class SessionViewController: CUIBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showVideoAlert(){
        //创建系统弹出框
        let alertViewController:UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let audioAction:UIAlertAction = UIAlertAction(title:"添加好友", style:UIAlertAction.Style.default) { [weak self] (UIAlertAction) in
            self?.getQRCodeUrl()
        }
        alertViewController.addAction(audioAction)
        let videoAction:UIAlertAction = UIAlertAction(title:"扫码", style:UIAlertAction.Style.default) { [weak self] (UIAlertAction) in
            self?.startScan()
        }
        alertViewController.addAction(videoAction)
        let logoutAction:UIAlertAction = UIAlertAction(title:"Logout", style:UIAlertAction.Style.default) { [weak self] (UIAlertAction) in
            //logout
            IMuiApi.getInstance().logout { [weak self] (response:PHResponse<Bool>) in
                if response.isSuccess == true{
                    DispatchQueue.main.async{
                        UserDefaults.standard.removeObject(forKey: "Test_User_Name2")
                        UserDefaults.standard.removeObject(forKey: "Test_Password2")
                        UserDefaults.standard.synchronize()
                        if let controller:UIViewController = self?.storyboard?.instantiateViewController(withIdentifier: "LoginViewController"){
                            self?.navigationController?.viewControllers = [controller]
                        }
                    }
                }
            }
        }
        alertViewController.addAction(logoutAction)
        let cancel:UIAlertAction = UIAlertAction(title:"取消", style:UIAlertAction.Style.cancel, handler: nil)
        alertViewController.addAction(cancel)
        self.present(alertViewController, animated:true, completion:nil)
    }
    
    func getQRCodeUrl(){
        self.showLoading()
        CUUserManager.getInstance().getQRCodeUrl { [weak self] (result: PHResponse<String>) in
            DispatchQueue.main.async {
                guard let `self` = self else { return }
                self.dismissLoading()
                if let urlStr: String = result.data {
                    let addVC = CUIFriendAddViewController.instanceFriendAddViewController()
                    addVC.qrCodeUrl = urlStr
                    self.navigationController?.pushViewController(addVC, animated: true)
                }else if let msg = result.msg, msg.count > 0 {
                    self.showToast(msg: msg)
                }
            }
        }
    }
    
    func startScan(){
        let scanVC:CUIScanerViewController = CUIScanerViewController.instanceScanViewController()
        self.navigationController?.pushViewController(scanVC, animated: true)
    }

}
