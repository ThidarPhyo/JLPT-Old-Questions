//
//  SettingsController.swift
//  sideMenu
//
//  Created by Thidar Phyo on 9/27/19.
//  Copyright © 2019 Thidar Phyo. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet weak var outletSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func darkAction(_ sender: UISwitch) {
        if outletSwitch.isOn == true {
            view.backgroundColor = UIColor.black
            label.textColor = UIColor.white
        } else {
            view.backgroundColor = UIColor.white
            label.textColor = UIColor.black
        }
    }
    

}
