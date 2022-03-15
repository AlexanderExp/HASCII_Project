//
//  ProductCell.swift
//  Smart Household
//
//  Created by Дмитрий Канский on 09.03.2022.
//

import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet var CellName: UITextField!
    @IBOutlet var CellInfo: UITextView!
    @IBOutlet var CellImage: UIImageView!
    @IBOutlet var CellCounter: UITextField!
    @IBOutlet var CellButtons: UIStepper!
    var cellID = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
