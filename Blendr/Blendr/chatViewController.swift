//
//  ChatViewController.swift
//  Yelpy
//
//  Created by Memo on 7/1/20.
//  Copyright © 2020 memo. All rights reserved.
//

/*------ Comment ------*/

import UIKit
import Parse

class ChatViewController: UIViewController {

    
    /*------ Outlets + Variables ------*/
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // ––––– LAB 5 TODO: CREATE ARRAY FOR MESSAGES
    var messages: [PFObject] = []
    
    // ––––– LAB 5 TODO: CREATE CHAT MESSAGE OBJECT
    let chatMessage = PFObject(className: "Message")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        
        
        // Reload messages every second (interval of 1 second)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.retrieveChatMessages), userInfo: nil, repeats: true)
        tableView.reloadData()
    }
    
    
    
    /*------  Message Functionality ------*/
    
    // ––––– Lab 5 TODO: ADD FUNCTIONALITY TO retrieveChatMessages()
    @objc func retrieveChatMessages() {
        // ParseClass.TrainingFall2020 is a string from our Constants.swift file
        let query = PFQuery(className: "Messages") // className = group chat name, obtained from Constants.swift
        query.addDescendingOrder("createdAt")
        query.limit = 20
        query.includeKey("user")
        query.findObjectsInBackground { (messages, error) in
            if let messages = messages {
                self.messages = messages
                self.tableView.reloadData()
            }
            else {
                print(error!.localizedDescription)
            }
        }
    }
    
    
    //  ––––– Lab 5 TODO: SEND MESSAGE TO SERVER AFTER onSend IS CLICKED
    @IBAction func onSend(_ sender: Any) {
        // ParseClass.TrainingFall2020 is a string from our Constants.swift file
        if messageTextField.text!.isEmpty == false {
            let chatMessage = PFObject(className: "Messages") // className = group chat, Obtained from Constants.swift
            chatMessage["text"] = messageTextField.text ?? ""
            chatMessage["user"] = PFUser.current()
            self.messageTextField.text = "" // reset message
            chatMessage.saveInBackground { (success, error) in
                if success {
                    print("The message was saved!")
                    
                } else if let error = error {
                    print("Problem saving message: \(error.localizedDescription)")
                }
            }
        } else {
            var dialogMessage = UIAlertController(title: "Error", message: "Message cannot be empty!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                print("Ok button tapped")
            }
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
            print("\nMessage cannot be empty\n")
        }
    }

}


/*------ TableView Extension Functions ------*/

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    
    // BONUS: IMPLEMENT CELL DIDSET
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        let message = messages[indexPath.row]
        cell.messageLabel.text = message["text"] as? String
        cell.messageLabel.layer.cornerRadius = 10
        cell.messageLabel.clipsToBounds = true
        
        // set the username
        if let user = message["user"] as? PFUser {
            cell.usernameLabel.text = user.username
        } else {
            cell.usernameLabel.text = "?"
        }
    

        return cell
    }
    
    
}



