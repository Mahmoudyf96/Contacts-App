//
//  UserDetailsVC.swift
//  ContactsApp
//
//  Created by McMoodie on 2021-04-28.
//

import UIKit
import Kingfisher

class UsersDetailVC: UIViewController {
    
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
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        profileImage.layer.masksToBounds = false
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 1.0
        
        name.text = "\(user.name.title) \(user.name.first) \(user.name.last)"
        email.text = "📧 " + user.email
        phoneNumber.text = "📱 " + user.phone
        address.text = "🏡 \(user.location.street.number) \(user.location.street.name)\n\(user.location.city), \(user.location.state) \(user.location.postcode)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let birthDate = dateFormatter.date(from: user.dob.date)
        dateFormatter.dateStyle = .long
        
        birthday.text = "🎉 " + dateFormatter.string(from: birthDate!) + "     Age: \(user.dob.age)"
    }
    
    

}
