//
//  GridCollectionViewCell.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/16/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    
    var item: ProductModel?
    
    func fill(item: ProductModel, indexpath : Int) {
        self.item = item
        
        imageProduct.image = UIImage(named: "icon_placeholder_m")
        let stringEncode = item.imageUrl.base64Encoded()!
        DataManager.getImageInDirectory(pathDirectory: "images", nameFile: stringEncode) { (image, name) in
            self.handleFinishLoadImage(name: name, image: image)
        }
        //imageProduct.backgroundColor = UIColor
        nameProduct.text = item.name
        nameProduct.backgroundColor = UIColor.white
        //imageProduct.clipsToBounds = true
    }
    
    func handleFinishLoadImage(name: String, image: UIImage) {
        DispatchQueue.main.async {
            guard self.item?.imageUrl.base64Encoded() == name else {
                return
            }
            self.imageProduct.image = image
            //image.size = imageProduct.siz
        }
    }
    
}
