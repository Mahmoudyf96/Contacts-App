//
//  ImageViewCell.swift
//  ContactsApp
//
//  Created by McMoodie on 2021-04-28.
//

import UIKit

class ImageViewCell: UITableViewCell {
    
    var mainImage: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(mainImage)
        
        mainImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        mainImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
