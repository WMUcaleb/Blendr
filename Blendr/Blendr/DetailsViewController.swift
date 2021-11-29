//
//  DetailsViewController.swift
//  Blendr
//
//  Created by Selyn Ung on 11/29/21.
//

import UIKit
import AlamofireImage

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var onReviewButton: UIButton!
    
    
    var r: Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        restaurantImage.af.setImage(withURL: r.imageURL!)
        restaurantLabel.text = r.name
        categoryLabel.text = r.mainCategory
        addressLabel.text = r.address
        
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
