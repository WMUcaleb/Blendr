//
//  HomeViewController.swift
//  Blendr
//
//  Created by Selyn Ung on 11/22/21.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var restaurantsArray: [Restaurant] = []
    var favoritesArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getAPIData()
        
        tableView.rowHeight = 150
        
        // Do any additional setup after loading the view.
    }
    
    func getAPIData(){
            API.getRestaurants(){ (restaurants) in
                guard let restaurants = restaurants else {
                    return
                }
    //            print(restaurants)
                self.restaurantsArray = restaurants
                self.tableView.reloadData()
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create Restaurant Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let restaurant = restaurantsArray[indexPath.row]
        
        
        cell.r = restaurant

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let r = restaurantsArray[indexPath.row]
            let detailViewController = segue.destination as! DetailsViewController
            detailViewController.r = r
            tableView.deselectRow(at: indexPath, animated: true)
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
