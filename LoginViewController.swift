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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
            
            let parametesrs: Parameters = [
                "username" : usernameTextField.text!,
                "password" : passwordTextField.text!
            ]
            
            Alamofire.request("http://mastermakrela.eu/bookchallenge/ios/mobileLogin.php", method: .post, parameters: parametesrs).responseString { response in
                if let id = Int(response.value!) {
                    userID = id
                    
                    //TODO - Remember Me feature
                    /*
                    rememberMe.username = self.usernameTextField.text!
                    rememberMe.password = self.passwordTextField.text!
                    rememberMe.remember = true
                    */
                    
                    self.performSegue(withIdentifier: "LoginSegue", sender: self.usernameTextField.text)
                } else {
                    let alert = UIAlertController(title: "Login Error", message: "Wrong Username or Password or account with this username does not exist", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
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
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("SEG")
        let tabBarController = segue.destination as! UITabBarController
        
        if let nextVC = tabBarController.viewControllers?[0] as? StatusViewController {
            nextVC.setUsername = self.usernameTextField.text!
        }
    }
    
    
}
