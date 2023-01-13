//
//  LoginViewController.swift
//  Proyecto
//
//  Created by Oscar Rodriguez Garrucho on 15/12/22.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(openKeyboard),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(closeKeyboard),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func openKeyboard() {
        print("open Keyboard")
    }
    
    @objc func closeKeyboard() {
        print("close Keyboard")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // don't make UI changes
        // do for calling the API
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        emailTextField.center.x -= view.bounds.width
        passwordTextField.center.x -= view.bounds.width
        loginButton.alpha = 0
        
        //
        UIView.animate(withDuration: 3,
                       delay: 0,
                       usingSpringWithDamping: 0.75,
                       initialSpringVelocity: 0,
                       options: []) {
            self.emailTextField.center.x += self.view.bounds.width
            self.passwordTextField.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 3) {
            self.loginButton.alpha = 1
        }
    }
        

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            print("email is empty")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            print("password is empty")
            return
        }
        
        NetworkLayer.shared.login(email: email, password: password) { token, error in
            if let token = token {
                LocalDataLayer.shared.save(token: token)
                print("We got a valid token!")
                print(token)
                
                DispatchQueue.main.async {
                    // deprecated form
                    //UIApplication.shared.keyWindow?.rootViewController = HomeTabBarController()
                    
                    UIApplication
                        .shared
                        .connectedScenes
                        .compactMap{ ($0 as? UIWindowScene)?.keyWindow }
                        .first?
                        .rootViewController = HomeTabBarController()
                }
                
                
            } else {
                print("Login Error: ", error?.localizedDescription ?? "")
            }
        }
    }
    
    
}
