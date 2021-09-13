//
//  AthleteCell.swift
//  KitmanApp
//
//  Created by Fabio Dantas on 13/09/2021.
//

import UIKit
import Kingfisher

class AthleteCell: UITableViewCell {
    
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var squadsLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(athlete: Athlete) {
        // Image loading
        avatarImage.kf.indicatorType = .activity
        if let url = URL(string: athlete.image.url) {
            avatarImage.kf.setImage(with: url)
        } else {
            // Default image
        }
        let fullName = "\(athlete.first_name) \(athlete.last_name)"
        nameLabel.text = fullName.capitalized
        usernameLabel.text = athlete.username
        squadsLabel.text = athlete.squads?.map { String($0) }.joined(separator: ",").capitalized
    }

}
