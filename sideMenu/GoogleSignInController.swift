//
//  GoogleSignInController.swift
//  sideMenu
//
//  Created by Thidar Phyo on 9/24/19.
//  Copyright © 2019 Thidar Phyo. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import FirebaseAuth


class GoogleSignInController: UIViewController, LoginButtonDelegate, GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGoogleButtons()
        setupFacebookButtons()
        
    }
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil {
            print(error)
            return
        }
        showEmailAddress()
        print("Successfully logged in with facebook.... ")
        
    }
    func showEmailAddress() {
        let accessToken = AccessToken.current
        
        guard let accessTokenString = accessToken?.tokenString else { return}
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString )
        
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
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Did Log out of facebook")
    }
    fileprivate func setupGoogleButtons() {
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 16, y: 116, width: view.frame.width - 32, height: 50)
        view.addSubview(googleButton)
        let customButton = UIButton(type: .system)
        customButton.frame = CGRect(x: 16, y: 116 + 66, width: view.frame.width - 32, height: 50)
        customButton.backgroundColor = .blue
        customButton.setTitle("Custom Google", for: .normal)
        customButton.addTarget(self, action: #selector(handleCustomGoogleSignIn), for: .touchUpInside)
        customButton.setTitleColor(.white, for: .normal)
        customButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        view.addSubview(customButton)
        GIDSignIn.sharedInstance()?.delegate = self
    }
    @objc func handleCustomGoogleSignIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    

}
