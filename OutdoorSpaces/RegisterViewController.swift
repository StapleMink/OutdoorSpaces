//
//  RegisterViewController.swift
//  OutdoorSpaces
//
//  Created by Daniel Budziwojski on 10/4/18.
//  Copyright © 2018 Sandbox Apps. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var rePasswordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func register(_ sender: Any) {
        //Call Login API
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        rePasswordField.resignFirstResponder()
        registerButton.isEnabled = false
        
        let size = CGFloat(150)
        let indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: self.view.center.x - (size/2), y: self.view.center.y - (size/2), width: size, height: size)
        //indicator.color = UIColor(hexString: "0073e6")
        indicator.startAnimating()
        view.addSubview(indicator)
        
        //Check if passwords entered are identical
        if(passwordField.text == rePasswordField.text) {
            
            
            //Send Credentials
            let passkey = "ndgn1PloHnXzg6ri"
            let salt = "12345" //Gen Salt
            let defaultTier = "Newby"
            let loginUrl = "https://www.outdoorspacesapp.com/dbm/api/createuser.php"
            var register = URLRequest(url: URL(string: loginUrl)!)
            let body = "email=\(emailField.text ?? "")&password=\((passwordField.text ?? "")/*.sha256()*/)&salt=\(salt)&firstName=\(firstNameField.text ?? "")&lastName=\(lastNameField.text ?? "")&points=0&tier=\(defaultTier)&passkey=\(passkey)"
            
            register.httpMethod = "POST"
            register.httpBody = body.data(using: String.Encoding.utf8);
            
            URLSession(configuration: .ephemeral).dataTask(with: register) { (data, response, error) in
                if let error = error {
                    print(error)
                    let alertController = UIAlertController(title: "ERROR", message: "An error occured when registering. Please try again later.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                } else if let data = data {
                    //let dataString:String = String(data: data, encoding: .utf8) ?? "Does not look like a utf8 response :("
                    //print(dataString)
                    let serverResponse = (try? JSONSerialization.jsonObject(with: data)) as? [String:Any] ?? [:]
                    //let serverResponseDetails = serverResponse["data"] as? [String:Any] ?? [:]
                    let failureStatus = serverResponse["error"] as? Bool ?? true
                    
                    //Send Auth response back
                    if(!failureStatus) {
                        //Push New View
                        /*DispatchQueue.main.async {
                            let appHome = self.storyboard?.instantiateViewController(withIdentifier: "AppHome") as! UITabBarController
                            self.navigationController?.pushViewController(appHome, animated: true)
                            indicator.removeFromSuperview()
                            self.passwordField.text = ""
                            //self.passwordField.becomeFirstResponder()
                        }*/
                    } else {
                        /*DispatchQueue.main.async {
                            self.passwordField.text = ""
                            self.passwordField.becomeFirstResponder()
                            //self.loginButton.isHidden = false
                            //Kill Activity Indicator
                            indicator.removeFromSuperview()
                        }*/
                    }
                }
                }.resume()
        } else {
            //Error passwords do not match
            let passNoMatchAlertController = UIAlertController(title: "Error", message: "Passwords do not match!", preferredStyle: .alert)
            let passNoMatchAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            passNoMatchAlertController.addAction(passNoMatchAction)
            self.present(passNoMatchAlertController, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        rePasswordField.delegate = self
        //registerButton.isEnabled = false
    }
    
    //TODO: Transitions from text fields
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        /*let usernameCharCount = (usernameField.text ?? "").count
        
        if(textField == usernameField) {
            //Hide the keyboard
            textField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        } else {
            //If is password field
            if(usernameCharCount > 0) {
                //Hide the keyboard
                textField.resignFirstResponder()
                loginButtonPressed(self)
            } else {
                textField.resignFirstResponder()
                usernameField.becomeFirstResponder()
            }
        }*/
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /*let usernameCharCount = (usernameField.text ?? "").count
        let passwordCharCount = (passwordField.text ?? "").count
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if(textField == usernameField) {
            if (!text.isEmpty && passwordCharCount > 0){
                loginButton.isEnabled = true
            } else {
                loginButton.isEnabled = false
            }
        } else {
            if (!text.isEmpty && usernameCharCount > 0){
                loginButton.isEnabled = true
            } else {
                loginButton.isEnabled = false
            }
        }*/
        
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
