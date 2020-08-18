//
//  ChatViewController.swift
//  Demo
//
//  Created by adam on 2020/8/18.
//  Copyright © 2020 awesome. All rights reserved.
//

import UIKit
import iMApi
import cableUi

class ChatViewController: UIViewController {
    
    var session:CUSession?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller:CUIIMViewController = segue.destination as? CUIIMViewController{
            print("segue.destination = \(segue.destination)")
            controller.sessionInfo = self.session
        }
    }

}
