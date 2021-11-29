//
//  ReviewViewController.swift
//  Blendr
//
//  Created by Selyn Ung on 11/29/21.
//

import UIKit
import Parse

class ReviewViewController: UIViewController {
    
    var r: Restaurant!
    var rating: Int = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingControl: UISegmentedControl!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var reviewField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        restaurantLabel.text = r.name
    }
    
    @IBAction func setRating(_ sender: Any) {
        let ratingList = [1, 2, 3, 4, 5]
        rating = ratingList[ratingControl.selectedSegmentIndex]
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        let review = PFObject(className: "Reviews")
        
        review["rating"] = rating
        review["content"] = reviewField.text!
        review["user"] = PFUser.current()!
        review["username"] = PFUser.current()?.username
        review["restaurant"] = r.name
        
        review.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved review!")
            } else {
                print("error!")
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
