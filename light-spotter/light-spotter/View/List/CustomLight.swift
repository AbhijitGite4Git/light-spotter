//
//  CustomLight.swift
//  light-spotter
//
//  Created by Abhijit Gite on 29/8/20.
//  Copyright © 2020 Abhijit Gite. All rights reserved.
//

import UIKit

class CustomLight: UITableViewCell {

    @IBOutlet weak var lblRight: UILabel!
    @IBOutlet weak var lblLeft: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
