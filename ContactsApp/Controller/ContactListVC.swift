//
//  ViewController.swift
//  ContactsApp
//
//  Created by McMoodie on 2021-04-28.
//

import UIKit
import Kingfisher

class ContactListVC: UITableViewController, emailUpdatedDelegate {
    
    static var users = [User]()
    var urlString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UpdateEmailVC.delegate = self
        
        let navItem = navigationController?.tabBarItem
        
        if navItem?.title == "Canadian" {
            urlString = "https://randomuser.me/api/1.3/?results=50&nat=ca"
        } else if navItem?.title == "Brazilian" {
            urlString = "https://randomuser.me/api/1.3/?results=50&nat=br"
        } else if navItem?.title == "Australian" {
            urlString = "https://randomuser.me/api/1.3/?results=50&nat=au"
        } else if navItem?.title == "French" {
            urlString = "https://randomuser.me/api/1.3/?results=50&nat=fr"
        }
        
        downloadData(url: urlString)
        ContactListVC.users = ContactListVC.users.sorted { $0.name.first < $1.name.first }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactListVC.users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let user = ContactListVC.users[indexPath.row]
        
        
        if let imageURL = URL(string: user.picture.medium) {
            cell.imageView?.kf.setImage(with: imageURL) { result in
                cell.setNeedsLayout()
            }
            cell.imageView?.makeRounded()
        }
        
        //Setting the users name
        cell.textLabel?.text = "\(user.name.title) \(user.name.first) \(user.name.last)"
        cell.textLabel?.font = UIFont(name: "Avenir Roman", size: 15)
        
        //Setting the users email & phone number
        cell.detailTextLabel?.text = "\(user.email) - \(user.phone)"
        cell.detailTextLabel?.font = UIFont(name: "Avenir", size: 11)
        
        return cell
    }
    
    func emailUpdated(value: String) {
        tableView.reloadData()
        print("data reloaded")
    }
    
    //Passing Data from the contact list to the users detailed view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let selectedRow = self.tableView.indexPath(for: cell)!.row
            if segue.identifier == "toUserInfo" {
                let destinationVC = segue.destination as! UsersDetailVC
                destinationVC.selectedRow = selectedRow
                destinationVC.user = ContactListVC.users[selectedRow]
            }
        }
    }
    
    
    
    //Downloading JSON data from an API, parsing it then appending it to our object
    func downloadData(url: String) {
        if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
                ContactListVC.users = parseJSON(json: data)
                print("We got the data!")
                tableView.reloadData()
            } else {
                showError()
            }
        }
    }
    
    //Parsing JSON
    func parseJSON(json: Data) -> [User] {
        let jsonDecoder = JSONDecoder()
        
        do {
            let parsedJSON = try jsonDecoder.decode(Users.self, from: json)
            return parsedJSON.results
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    //Error Alert
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the JSON Feed! Check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}





