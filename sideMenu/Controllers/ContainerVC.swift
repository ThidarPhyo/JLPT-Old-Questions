//
//  ContainerVC.swift
//  sideMenu
//
//  Created by Thidar Phyo on 9/22/19.
//  Copyright © 2019 Thidar Phyo. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {

    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    var sideMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.leftBarButtonItem?.image = UIImage(named: "menu-button")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toggleSideMenu),
                                               name: NSNotification.Name("ToggleSideMenu"),
                                               object: nil)
    }
    
    
    @objc func toggleSideMenu() {
        if sideMenuOpen {
            //navigationItem.leftBarButtonItem?.image = UIImage(named: "menu-button")
            sideMenuOpen = false
            sideMenuConstraint.constant = -240
//            print("Hello")
            
            
            
        } else {
            //navigationItem.leftBarButtonItem?.image = UIImage(named: "close")
            sideMenuOpen = true
            sideMenuConstraint.constant = 0
             //
        }
//        UIView.animate(
//          withDuration: 0.5,
//          delay: 0,
//          usingSpringWithDamping: 0.7,
//          initialSpringVelocity: 0.8,
//          options: .curveEaseInOut,
//          animations: {
//            // Do animation
//
//        }, completion: nil)
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
            //self.view.backgroundColor = .red

        }
    }
    


}
