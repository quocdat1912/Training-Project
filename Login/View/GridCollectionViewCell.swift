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
    
    func fill(item: ProductModel) {
        self.item = item
        
        cell.imageProduct.image = UIImage(named: "icon_placeholder_m")
        let stringEncode = items[indexPath.row].imageUrl.base64Encoded()!
        DataManager.getImageInDirectory(pathDirectory: "images", nameFile: stringEncode) { (image) in
            if cellTag == indexPath.row {
                cell.imageProduct.image = image
            }
        }
        
        cell.nameProduct.text = items[indexPath.row].name
        
        
    }
    
    func handleFinishLoadImage(name: String, image: UIImage) {
        guard self.item?.imageUrl.base64Encoded() == name else {
            return
        }
        imageProduct.image = image
    }
    
}
