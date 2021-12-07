//
//  RestaurantCell.swift
//  Blendr
//
//  Created by Selyn Ung on 11/22/21.
//

import UIKit
import Parse

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    
    var r: Restaurant! {
            didSet {
                restaurantLabel.text = r.name
                categoryLabel.text = r.mainCategory
                numberLabel.text = r.phone
                reviewLabel.text = String(r.reviews) + " reviews"
                restaurantImage.af.setImage(withURL: r.imageURL!)
                restaurantImage.layer.cornerRadius = 10
                restaurantImage.clipsToBounds = true
            }
        }
    
    var favorited:Bool = false
    
    @IBAction func onClickFavorite(_ sender: Any) {
        let toBeFavorited = !favorited
        let favorited = PFObject(className: "Favorited_Restaurant")
        
        favorited["name"] = restaurantLabel.text!
        favorited["category"] = categoryLabel.text!
        favorited["user"] = PFUser.current()!
        let imageData = restaurantImage.image!.pngData()
        let file = PFFileObject(data: imageData!)
        favorited["image"] = file
        
        if (toBeFavorited) {
            favorited.saveInBackground { (success, error) in
                if success {
                    print("saved!")
                }else {
                    print("error!")
                }
            }
            self.setFavorite(true)
        }
        (sender as? UIButton)?.isEnabled = false
    }
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if (favorited) {
            favoriteButton.setImage(UIImage(named: "red-favorite"), for: UIControl.State.normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favorite"), for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
