//
//  UserProfileViewController.swift
//  sideMenu
//
//  Created by Thidar Phyo on 11/2/19.
//  Copyright © 2019 Thidar Phyo. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    
    @IBOutlet weak var displayName: UILabel!
    
    @IBOutlet weak var inputField: UITextField!
    let KEY: String = "DEFAULT_USER"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let savedValue = defaults.string(forKey: KEY)
        if let parsedSaveValue = savedValue {
            displayName.text = "Name: \(parsedSaveValue)"
            inputField.text = "\(parsedSaveValue)"
        } else {
            displayName.text = "Please Enter User Name"
        }
        
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        
        
        if isValidUser(inputField.text!) {
            let input = inputField.text!
            let defaults = UserDefaults.standard
            defaults.set(input, forKey: KEY)
            displayName.text = "User Name : \(input)"
            inputField.text = ""
            //inputField.text = "\(input)"
            
        } else {
            //Alert.showBasicAlert(on: self, with: "Please Fill", message: "Your amount!")
            let alert = UIAlertController(title: "Empty Name", message: "Please Enter your name.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

            print("Please Fill")
        }
    }
    func isValidUser(_ user: String) -> Bool {
        return user.count >= 1
    }
    

}
