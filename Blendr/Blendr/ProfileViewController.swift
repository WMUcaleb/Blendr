//
//  ProfileViewController.swift
//  Blendr
//
//  Created by Selyn Ung on 11/22/21.
//

import UIKit
import AlamofireImage
import Parse
import Foundation

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var usernameImage: UIImageView!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var showActionSheetButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let user = PFUser.current()
        
        let date = user?.createdAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, y"
        
        dateLabel.text = "Joined on " + dateFormatter.string(from: date!)
        usernameLabel.text = user?.username
        emailLabel.text = user?.email
        
        let imageFile = user?["photo"] as? PFFileObject
        if (imageFile != nil) {
            let urlString = imageFile?.url!
            let url = URL(string: urlString!)!
            profileImage.af.setImage(withURL: url)
            profileImage.layer.cornerRadius = 50
            profileImage.clipsToBounds = true
        }
        
        
    }
    
    
    @IBAction func showActionSheetButtonTapped(_ sender: Any) {
        
        let profileActionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to change your profile picture?", preferredStyle: UIAlertController.Style.actionSheet)
        
        let cameraAction = UIAlertAction(title:"Camera", style: UIAlertAction.Style.default) { (action) in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
            } else {
                picker.sourceType = .photoLibrary
            }
            
            self.present(picker, animated: true, completion: nil)
            print("Camera button tapped")
        }
        
        let libraryAction = UIAlertAction(title:"Photo Library", style: UIAlertAction.Style.default) { (action) in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            
            picker.sourceType = .photoLibrary
            
            self.present(picker, animated: true, completion: nil)
            print("Library button tapped")
        }
        
        let cancelAction = UIAlertAction(title:"Cancel", style: UIAlertAction.Style.cancel) { (action) in
            print("Cancel button tapped")
        }
        
        profileActionSheet.addAction(cameraAction)
        profileActionSheet.addAction(libraryAction)
        profileActionSheet.addAction(cancelAction)
        
        self.present(profileActionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 253, height: 253)
        let scaledImage = image.af.imageScaled(to: size)
        
        profileImage.image = scaledImage
        
        let imageData = self.profileImage.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        PFUser.current()!["photo"] = file
        
        PFUser.current()?.saveInBackground(block: { (success, error) in
            if success {
                print("saved profile photo!")
            } else {
                print("error!")
            }
        })
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginViewController
    
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
