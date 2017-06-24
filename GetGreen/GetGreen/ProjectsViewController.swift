//
//  ProjectsViewController.swift
//  GetGreen
//
//  Created by Annie Tung on 6/24/17.
//  Copyright © 2017 Liam Kane. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ProjectsViewController: UIViewController {

    var databaseReference: FIRDatabaseReference!
    @IBOutlet weak var textView: UITextView!

    @IBAction func submitButtonPressed(_ sender: UIButton) {

        let databaseRef = FIRDatabase.database().reference().child("Project")
        let newProject = databaseRef.childByAutoId()
        let newItem: [String:AnyObject] = [
            "name" : textView.text as AnyObject
        ]
        newProject.setValue(newItem)
        showSuccessAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        databaseReference = FIRDatabase.database().reference()
        fetchDatabase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Methods
    func showSuccessAlert() {
        let alert = UIAlertController(title: "Success!", message: "Your project has been posted", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func fetchDatabase() {
//        let userID = Auth.auth().currentUser?.uid
//        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//
//            let value = snapshot.value as? NSDictionary
//            let username = value?["username"] as? String ?? ""
//            let user = User.init(username: username)
//            
//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }
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
