//
//  DetailsViewController.swift
//  Blendr
//
//  Created by Selyn Ung on 11/29/21.
//

import UIKit
import AlamofireImage
import Parse

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var onReviewButton: UIButton!
    @IBOutlet weak var reviewTableView: UITableView!

    var r: Restaurant!
    var reviews = [PFObject]()
    
    let myRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        restaurantImage.af.setImage(withURL: r.imageURL!)
        restaurantLabel.text = r.name
        categoryLabel.text = r.mainCategory
        addressLabel.text = r.address
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        
        reviewTableView.rowHeight = 100
        
        myRefreshControl.addTarget(self, action: #selector(viewDidAppear(_:)), for: .valueChanged)
        reviewTableView.refreshControl = myRefreshControl
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let query = PFQuery(className: "Reviews")
        query.whereKey("restaurant", equalTo: r.name)
        
        query.findObjectsInBackground { (reviews, error) in
            if reviews != nil {
                self.reviews = reviews!
                self.reviews.reverse()
                self.reviewTableView.reloadData()
            }
        }
        
        self.myRefreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reviewTableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
        
        let review = reviews[indexPath.row]
        cell.usernameLabel.text = review["username"] as? String
        cell.contentLabel.text = review["content"] as? String
        
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewSegue" {
            let reviewViewController = segue.destination as! ReviewViewController
            reviewViewController.r = r
            reviewViewController.r = r
        } else if segue.identifier == "mapSegue" {
            let mapViewController = segue.destination as! MapViewController
            mapViewController.r = r
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
