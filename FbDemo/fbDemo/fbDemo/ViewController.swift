//
//  ViewController.swift
//  fbDemo
//
//  Created by Yagnik Suthar on 12/09/19.
//  Copyright © 2019 bito1. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookLogin

class ViewController: UIViewController {
    
    var dict : [String : AnyObject]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //creating button
        let loginButton = FBLoginButton(permissions: [ .publicProfile ])
        loginButton.center = view.center
        
        //adding it to view
        view.addSubview(loginButton)
        
        //if the user is already logged in
        if let accessToken = AccessToken.current{
            getFBUserData()
        }
    }
    
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success( _, _, _):
                self.getFBUserData()
            }
        }
    }
    
    //function is fetching the user data
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as? [String : AnyObject]
                    print(result!)
                    print(self.dict as Any)
                }
            })
        }
    }

}

