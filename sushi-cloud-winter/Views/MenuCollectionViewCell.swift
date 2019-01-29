//
//  MenuCollectionViewCell.swift
//  sushi-cloud-winter
//
//  Created by Alan Victor Paulino de Oliveira on 28/01/19.
//  Copyright © 2019 Alan Victor Paulino de Oliveira. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoDish: UIImageView!
    @IBOutlet weak var nameDish: UILabel!
    @IBOutlet weak var checkBox: UIImageView!
    
    var plate:Plates?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func loadCell(){
        if let image = plate?.image{
            photoDish.image = image
        }else{
            photoDish.image = UIImage(imageLiteralResourceName: "defaultSushi")
        }
        nameDish.text = plate?.name
    }
    
    func selectedCheckbox(){
        if let selected = plate?.selected,selected{
            plate!.selected = false
            checkBox.isHidden = true
        }else{
            plate!.selected = true
            checkBox.isHidden = false
        }
    }
}
