//
//  FavoriteRestaurantTableViewCell.swift
//  Blendr
//
//  Created by Ka Kit Leng on 11/22/21.
//

import UIKit

class FavoriteRestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var restuarantTitle: UILabel!
    @IBOutlet weak var favoritedSince: UILabel!
    @IBOutlet weak var restaurantPoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
