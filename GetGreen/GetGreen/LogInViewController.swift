//
//  LogInViewController.swift
//  GetGreen
//
//  Created by C4Q on 6/24/17.
//  Copyright © 2017 Liam Kane. All rights reserved.
//

import UIKit
import Alamofire

class LogInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://data.cityofnewyork.us/resource/yes4-7zbb.json")!
        Alamofire.request(url).responseJSON { (jsonResponse) in
            print(jsonResponse.result.value!)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        self.view.backgroundColor = .blue
    }
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        self.view.backgroundColor = .white
    }
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        
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
