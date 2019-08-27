//
//  mealTableViewCell.swift
//  mealLog
//
//  Created by Jianli He on 8/12/19.
//  Copyright © 2019 Jianli He. All rights reserved.
//

import UIKit

class mealTableViewCell: UITableViewCell {
    //MARK: properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
