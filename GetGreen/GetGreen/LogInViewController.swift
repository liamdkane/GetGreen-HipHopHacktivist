//
//  LogInViewController.swift
//  GetGreen
//
//  Created by C4Q on 6/24/17.
//  Copyright © 2017 Liam Kane. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {

        if let email = emailTextField.text, let password = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if user != nil {
                    let alert = UIAlertController(title: "Login Successful!", message: "Welcome", preferredStyle: .actionSheet)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let svc = storyboard.instantiateViewController(withIdentifier: "showHome")
                        self.present(svc, animated: true, completion: nil)
                    })
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Login failed!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {

        if let email = emailTextField.text, let password = passwordTextField.text {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if user != nil {
                    print("User can register!!")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let svc = storyboard.instantiateViewController(withIdentifier: "showHome")
                    self.present(svc, animated: true, completion: nil)
                }
                else {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let svc = storyboard.instantiateViewController(withIdentifier: "showHome")
        self.present(svc, animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
