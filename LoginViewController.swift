//
//  LoginViewController.swift
//  BookChallenge
//
//  Created by Krzysztof Kostrzewa on 07/05/2017.
//  Copyright © 2017 Krzysztof Kostrzewa. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.bool(forKey: "rememberMe"){
            
            if let username = defaults.string(forKey: "username"), let password = defaults.string(forKey: "password") {
                usernameTextField.text = username
                login(username: username, password: password)
            }
        }
        
        
        
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        if (usernameTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "No Username", message: "Please fill in the username field and try again", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else if (passwordTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "No Password", message: "Please fill in the password field and try again", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            login(username: usernameTextField.text!, password: passwordTextField.text!)
            
        }
    }
    
    private func login(username: String, password: String){
        
        let parametesrs: Parameters = [
            "username" : username,
            "password" : password
        ]
        
        Alamofire.request("http://mastermakrela.eu/bookchallenge/ios/mobileLogin.php", method: .post, parameters: parametesrs).responseString { response in
            if let id = Int(response.value!) {
                userID = id
                
                //Remember Me
                if self.rememberMeSwitch.isOn {
                    defaults.set(self.usernameTextField.text!, forKey: "username")
                    defaults.set(self.passwordTextField.text!, forKey: "password")
                    defaults.set(self.rememberMeSwitch.isOn, forKey: "rememberMe")
                }
                
                self.performSegue(withIdentifier: "LoginSegue", sender: self.usernameTextField.text)
            } else {
                let alert = UIAlertController(title: "Login Error", message: "Wrong Username or Password or account with this username does not exist", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: "http://mastermakrela.eu/bookchallenge/register.php")!)
    }
    
    // Return key moves to next field
    // Adapted from: http://stackoverflow.com/a/31766986
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBarController = segue.destination as! UITabBarController
        
        if let nextVC = tabBarController.viewControllers?[0] as? StatusViewController {
            nextVC.setUsername = self.usernameTextField.text!
        }
    }
    
    
}
