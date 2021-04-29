//
//  ViewController.swift
//  ContactsApp
//
//  Created by McMoodie on 2021-04-28.
//

import UIKit
import Kingfisher

class ContactListVC: UITableViewController {
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = [
            "https://randomuser.me/api/1.3/?results=150&nat=ca",
            "https://randomuser.me/api/1.3/?results=150&nat=br",
            "https://randomuser.me/api/1.3/?results=150&nat=au",
            "https://randomuser.me/api/1.3/?results=150&nat=fr"
        ]
        
        
        if let url = URL(string: urlString[0]) {
            if let data = try? Data(contentsOf: url) {
                print("Data is parsing!")
                parse(json: data)
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonUsers = try? decoder.decode(Users.self, from: json) {
            users = jsonUsers.results
            print("We got the Data!")
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        
        let user = users[indexPath.row]
        
        if let imageURL = URL(string: user.picture.medium) {
            cell.imageView?.kf.setImage(with: imageURL) { result in
                cell.setNeedsLayout()
            }
            cell.imageView?.layer.cornerRadius = 30
            cell.imageView?.layer.masksToBounds = true
            cell.imageView?.layer.borderWidth = 1.0
        }
        
        cell.textLabel?.text = "\(user.name.title) \(user.name.first) \(user.name.last)"
        cell.textLabel?.font = UIFont(name: "Avenir Roman", size: 15)
        
        cell.detailTextLabel?.text = "\(user.email) - \(user.phone)"
        cell.detailTextLabel?.font = UIFont(name: "Avenir", size: 11)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let i = self.tableView.indexPath(for: cell)!.row
            if segue.identifier == "toUserInfo" {
                let vc = segue.destination as! UsersDetailVC
                vc.user = users[i]
            }
        }
    }
}

