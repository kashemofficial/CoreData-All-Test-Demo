//
//  ListTableViewCell.swift
//  HitList
//
//  Created by Abul Kashem on 29/1/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameListLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
