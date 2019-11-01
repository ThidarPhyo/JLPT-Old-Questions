//
//  ViewController.swift
//  sideMenu
//
//  Created by Thidar Phyo on 9/22/19.
//  Copyright © 2019 Thidar Phyo. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class ViewController: UIViewController, LoginButtonDelegate, GIDSignInDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFacebookButtons()
//        NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: NSNotification.Name("success"), object: nil)
        setupGoogleButtons()
//        if let key = UserDefaults.standard.object(forKey: "key"){
//
//            print("Hello World : \(key)")
//            performSegue(withIdentifier: "googleLoginsuccess", sender: nil)
//        }
//        else {
//
//        }
        
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print("Failed to log into Google: ", error)
            return
        }
        
        print("Successfully logged into Google", user)
        guard let idToken = user.authentication.idToken else { return }
        guard let accessToken = user.authentication.accessToken else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        Auth.auth().signIn(with: credentials, completion: { (user, error) in
            if let err = error {
                print("Failed to create a Firebase User with Google account: ", err)
                return
            }
            
            guard let uid = user?.user.uid else { return }
            print("Successfully logged into Firebase with Google", uid)
            UserDefaults.standard.set(uid, forKey: "key")
//            self.window?.rootViewController!.performSegue(withIdentifier: "googleLoginsuccess", sender: uid)
            self.performSegue(withIdentifier: "googleLoginsuccess", sender: nil)
            
            
        })
        
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
//    @objc func didSignIn()  {
//
//        // Add your code here to push the new view controller
//        navigationController?.pushViewController(View1Controller(), animated: true)
//
//    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil {
            print(error)
            return
        }
        
        showEmailAddress()
        
        //print("Successfully logged in with facebook.... ")

    }
//    func loginButton(_ loginButton: GIDSignInButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//        if error != nil {
//            print(error)
//            return
//        }
//        showEmailAddress()
//        print("Successfully logged in with google.... ")
//
//    }

    func showEmailAddress() {
        let accessToken = AccessToken.current
        
        guard let accessTokenString = accessToken?.tokenString else { return}
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString )
        print("credentials", credentials)
        Auth.auth().signIn(with: credentials) { (user, error) in
            if error != nil {
                print("Something went wrong with our FB user: " ,error ?? "" )
                return
            }
            
            print("Successfully logged in with our user: ", user ?? "")
            
        }
        
        GraphRequest(graphPath: "/me", parameters:["fields":"id, name, email"]).start { (connection, result, err) in
            if err != nil {
                print("Failed to start graph request:",err ?? ""  )
                return
            }
            print(result ?? "" )
        }
    }
    func userDefults() {
        if let key = UserDefaults.standard.object(forKey: "key"){
            
            print("Hello World : \(key)")
            performSegue(withIdentifier: "googleLoginsuccess", sender: nil)
        }
        else {
            
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logout")
    }
    
    
    
    
    fileprivate func setupGoogleButtons() {
        // add google signin button
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 16, y: 350 + 166, width: view.frame.width - 32, height: 50)
        view.addSubview(googleButton)
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        //userDefults()
        
        
    }
    
    
    fileprivate func setupFacebookButtons() {
        let loginButton = FBLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 200, width: view.frame.width - 32, height: 50)
        loginButton.delegate = self
        loginButton.permissions = ["email", "public_profile"]
        
        let customFBButton = UIButton(type: .system)
        customFBButton.backgroundColor = .blue
        customFBButton.frame = CGRect(x: 16, y: 350, width: view.frame.width - 32, height: 50)
        customFBButton.setTitle("Custom FB Login here", for: .normal)
        customFBButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        customFBButton.setTitleColor(.white, for: .normal)
        view.addSubview(customFBButton)
        
        customFBButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
    }
    
    @objc func handleCustomFBLogin() {
        LoginManager().logIn(permissions: ["email", "public_profile"], from: self) { (result, err) in
            if err != nil {
                print("FB Login Failed", err)
                return
            }
            //            print(result?.token?.tokenString)
            self.showEmailAddress()
        }
    }
    
    
    
}

