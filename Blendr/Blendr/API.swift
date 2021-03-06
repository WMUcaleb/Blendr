//
//  API.swift
//  Blendr
//
//  Created by Selyn Ung on 11/22/21.
//

import Foundation


struct API {
    

    static func getRestaurants(completion: @escaping ([Restaurant]?) -> Void) {
        
        // ––––– TODO: Add your own API key!
        let apikey = "f55VtJR7XuZsYiqvKogB9JLUL--9tUYl9rcQowQQoT51vyLb3ZOh6abYe_AIU4kJs4cZAEC-JKPk-Z09FoAUgH1K5w0COkcqaRZMlVAk9mHTuVzboLQGEMntzGZPYXYx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
                // ––––– TODO: Get data from API and return it using completion
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let restDict = dataDictionary["businesses"] as! [[String: Any]]
                
                let restaurants = restDict.map({ Restaurant.init(dict: $0) })
                
                // Using For Loop
//                var restaurants: [Restaurant] = []
//                for dictionary in dataDictionary {
//                    let restaurant = Restaurant.init(dict: dictionary as! [String : Any])
//                    restaurants.append(restaurant)
//                }

                                
                return completion(restaurants)
                
                }
            }
        
            task.resume()
        
        }
    
    

    
}
