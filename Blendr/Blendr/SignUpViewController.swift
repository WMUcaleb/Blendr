//
//  SignUpViewController.swift
//  Blendr
//
//  Created by Ka Kit Leng on 11/20/21.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "registerSegue", sender: nil)
            }else if (user.username == "") {
                var passwordDialogMessage = UIAlertController(title: "Error", message: "You will need to have a username to sign up", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                    print("Ok button tapped")
                }
                passwordDialogMessage.addAction(ok)
                self.present(passwordDialogMessage, animated: true, completion: nil)
            }else if (user.password == "") {
                var passwordDialogMessage = UIAlertController(title: "Error", message: "You will need to have a password to sign up", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                    print("Ok button tapped")
                }
                passwordDialogMessage.addAction(ok)
                self.present(passwordDialogMessage, animated: true, completion: nil)
            }else {
                var dialogMessage = UIAlertController(title: "Error", message: "There is already an account associated with this username", preferredStyle: .alert)
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
