//
//  MainVC.swift
//  sideMenu
//
//  Created by Thidar Phyo on 9/22/19.
//  Copyright © 2019 Thidar Phyo. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    //1
//    let imageView: UIImageView = {
//      let view = UIImageView(image: UIImage(imageLiteralResourceName: "menu-button"))
//      view.contentMode = .center
//      return view
//    }()

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.leftBarButtonItem?.image = UIImage(named: "menu-button")
        print("Hello")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.addSubview(imageView)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showProfile),
                                               name: NSNotification.Name("ShowProfile"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showSettings),
                                               name: NSNotification.Name("ShowSettings"),
                                               object: nil)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(showSignIn),
//                                               name: NSNotification.Name("ShowSignIn"),
//                                               object: nil)
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom) as! UIButton
        button.setImage(UIImage(named: "icon_setting"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(handleSettings), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 31)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
    }
    @objc func handleSettings() {
            let alert = UIAlertController(title: "About Us", message: "Developed by Thidar Phyo", preferredStyle: .alert)
    //        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.yellow
    //        alert.view.tintColor = .white
            let passAction = UIAlertAction(title: "Dismiss", style: .default) { (_) in
               
            }
            //let destriveAction = UIAlertAction(title: "Destory", style: .destructive, handler: nil)
            alert.addAction(passAction)
            //actionSheet.addAction(destriveAction)
            present(alert, animated: true, completion: nil)
        }
    
    @objc func showProfile() {
        performSegue(withIdentifier: "ShowProfile", sender: nil)
    }
    
    @objc func showSettings() {
        performSegue(withIdentifier: "ShowSettings", sender: nil)
    }
//    
//    @objc func showSignIn() {
//        performSegue(withIdentifier: "ShowSignIn", sender: nil)
//    }
    
    
    @IBAction func onMoreTapped() {
        //print("TOGGLE SIDE MENU")
        let view = UIImage(named: "menu-button")
        let close = UIImage(named: "close")
        //print(view?.pngData())
        
    
        let nav = self.navigationItem.leftBarButtonItem?.image
        //print("\n",nav?.pngData())
        //print(view?.pngData() == nav?.pngData())
        if view?.pngData() == nav?.pngData(){
            self.navigationItem.leftBarButtonItem?.image = close
        }else{
            self.navigationItem.leftBarButtonItem?.image = view
        }
        //print(nav)
        
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    
    
    
    
}

