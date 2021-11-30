//
//  FavoritesViewController.swift
//  Blendr
//
//  Created by Ka Kit Leng on 11/22/21.
//

import UIKit
import Parse
import AlamofireImage
import Foundation

class CellClass: UITableViewCell {
    
}

class FavoritesViewController: UIViewController {

    @IBOutlet weak var btnCuisine: UIButton!
    @IBOutlet weak var btnDistance: UIButton!
    @IBOutlet weak var restaurantTableView: UITableView!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    var dataSource = [String]()
    var favorited = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Favorited_Restaurant")
        query.whereKey("user", equalTo: PFUser.current())
        query.includeKey("user")
        query.limit = 20
        
        query.findObjectsInBackground { (favorited, error) in
            if favorited != nil {
                self.favorited = favorited!
                self.restaurantTableView.reloadData()
            }
        }
    }
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 3
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x + 5, y: frames.origin.y + frames.height, width: frames.width, height: CGFloat(self.dataSource.count * 60))
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    //change this when connected to API
    @IBAction func onClickCuisine(_ sender: Any) {
        dataSource = [
            "Japanese",
            "Korean",
            "Chinese",
            "Western"
        ]
        selectedButton = btnCuisine
        addTransparentView(frames: btnCuisine.frame)
    }
    
    //change this when connected to API
    @IBAction func onClickDistance(_ sender: Any) {
        dataSource = [
            "5 miles",
            "10 miles",
            "20 miles",
            "30 miles"
        ]
        selectedButton = btnDistance
        addTransparentView(frames: btnDistance.frame)
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == restaurantTableView {
            return favorited.count
        }else{
            return dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == restaurantTableView {
            let cell = restaurantTableView.dequeueReusableCell(withIdentifier: "FavoriteRestaurantTableViewCell") as! FavoriteRestaurantTableViewCell
            
            let favorite = favorited[indexPath.row]
            //let restaurantName = favorite["name"] as! PFUser
            cell.restuarantTitle.text = favorite["name"] as? String
            
            cell.restaurantCategory.text = favorite["category"] as? String
            let imageFile = favorite["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string:urlString)!
            cell.restaurantPoster.af.setImage(withURL: url)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = dataSource[indexPath.row]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == restaurantTableView {
            return 135
        }else {
        return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == restaurantTableView {
            print("it works!")
        }else {
        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
        }
    }
    
}
