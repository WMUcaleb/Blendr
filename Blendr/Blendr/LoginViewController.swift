//
//  LoginViewController.swift
//  Blendr
//
//  Created by Ka Kit Leng on 11/19/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
            let password = passwordField.text!
            
            PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
                if user != nil {
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                } else {
                    var dialogMessage = UIAlertController(title: "Error", message: "Username or Password error, please try again", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                        print("Ok button tapped")
                    }
                    dialogMessage.addAction(ok)
                    self.present(dialogMessage, animated: true, completion: nil)
                    print("Error: \(error?.localizedDescription)")
                }
            }
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
