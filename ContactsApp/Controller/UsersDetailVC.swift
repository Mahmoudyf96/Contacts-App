//
//  UserDetailsVC.swift
//  ContactsApp
//
//  Created by McMoodie on 2021-04-28.
//

import UIKit
import Kingfisher

class UsersDetailVC: UIViewController, emailUpdatedDelegate {
    
    var user: User?
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var birthday: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let user = user else { return }
        
        if let imageURL = URL(string: user.picture.large) {
            profileImage.kf.setImage(with: imageURL)
        }
        profileImage.makeRounded()
        
        name.text = "\(user.name.title) \(user.name.first) \(user.name.last)"
        
        let country: String = user.location.country
        
        if country == "Canada" {
            name.text = "🇨🇦 " + name.text!
        } else if country == "Brazil" {
            name.text = "🇧🇷 " + name.text!
        } else if country == "Australia" {
            name.text = "🇦🇺 " + name.text!
        } else {
            name.text = "🇫🇷 " + name.text!
        }
        
        email.text = "📧 " + user.email
        phoneNumber.text = "📱 " + user.phone
        
        var postalCode: Any
        
        switch user.location.postcode {
        case .int(let i):
            postalCode = i
        case .string(let s):
            postalCode = s
        }
        address.text = "🏡 \(user.location.street.number) \(user.location.street.name)\n\(user.location.city), \(user.location.state) \(postalCode)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let birthDate = dateFormatter.date(from: user.dob.date)
        dateFormatter.dateStyle = .long
        
        birthday.text = "🎉 " + dateFormatter.string(from: birthDate!) + "     Age: \(user.dob.age)"
        
        UpdateEmailVC.delegate = self
    }
    
    @IBAction func updateEmail(_ sender: UIButton) {
        performSegue(withIdentifier: "toUpdateEmail", sender: self)
    }
    
    func emailUpdated(value: String) {
        email.text = "📧 " + value
    }
}


