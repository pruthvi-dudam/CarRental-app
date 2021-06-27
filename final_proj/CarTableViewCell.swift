//
//  CarTableViewCell.swift
//  final_proj
//
//  Created by pruthvi raj dudam on 3/20/21.
//

import UIKit

class CarTableViewCell: UITableViewCell {
    

    @IBOutlet weak var car_name: UILabel!
    
    @IBOutlet weak var car_image: UIImageView!{
        didSet {
         car_image.layer.cornerRadius = car_image.bounds.width / 2
         car_image.clipsToBounds = true
         }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
