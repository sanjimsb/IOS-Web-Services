//
//  BreedCell.swift
//  Dog Breed
//
//  Created by Bipin Msb on 2022-06-11.
//

import UIKit

class BreedCell: UITableViewCell {

    @IBOutlet weak var subBreed: UILabel!
    @IBOutlet weak var breed: UILabel!
    @IBOutlet weak var BreedImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
