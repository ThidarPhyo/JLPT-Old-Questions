//
//  SideMenuVC.swift
//  sideMenu
//
//  Created by Thidar Phyo on 9/22/19.
//  Copyright © 2019 Thidar Phyo. All rights reserved.
//

import UIKit

class SideMenuVC: UITableViewController {
    
    
    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var settings: UIButton!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        
        switch indexPath.row {
        case 0: NotificationCenter.default.post(name: NSNotification.Name("ShowProfile"), object: nil);
            NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        case 1: NotificationCenter.default.post(name: NSNotification.Name("ShowSettings"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        case 2: NotificationCenter.default.post(name: NSNotification.Name("language"), object: nil)
        
        case 3: logout()
        default: break
        }
        
    }
    func logout() {

        showAlert(title: "Alert!", message: "Are you sure you want to logout?", handlerOk: { action in
            print("Action OK")
            UserDefaults.standard.removeObject(forKey: "key")
            self.dismiss(animated: true, completion: nil)
        }, handlerCancel: { actionCancel in
            print("Action cancel")
        })
        

    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Header"
    }
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerImage: UIImage = UIImage(named: "japan")!
//        let headerView = UIImageView(image: headerImage)
//        return headerView
//    }
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "Ma Ma"
//        return cell
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        logoutButton.layer.borderColor = UIColor.darkGray.cgColor
//        logoutButton.layer.borderWidth = 2
//        settings.layer.borderColor = UIColor.darkGray.cgColor
//        settings.layer.borderWidth = 2
//    }
    


}
