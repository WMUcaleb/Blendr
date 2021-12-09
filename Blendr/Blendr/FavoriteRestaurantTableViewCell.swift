//
//  FavoriteRestaurantTableViewCell.swift
//  Blendr
//
//  Created by Ka Kit Leng on 11/22/21.
//

import UIKit
import Parse

class FavoriteRestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var restuarantTitle: UILabel!
    @IBOutlet weak var restaurantPoster: UIImageView!
    @IBOutlet weak var restaurantCategory: UILabel!
    @IBOutlet weak var favoritedDate: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var favorite: PFObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func onRemoveButton(_ sender: Any) {
        let name = favorite["name"] as! String
        let query = PFQuery(className: "Favorited_Restaurant")
        query.whereKey("name", equalTo: name)
        query.findObjectsInBackground { (objects, error) in
            if error == nil,
                let objects = objects {
                for object in objects {
                    object.deleteInBackground()
                    
                }
            }
        }
    }
    
}
