//
//  ListCollectionViewCell.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/16/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var skuProduct: UILabel!
    @IBOutlet weak var qtyProduct: UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var viewCell1: UIView!
    @IBOutlet weak var viewCell2: UIView!
    
    var item: ProductModel?
    
    func fill(item: ProductModel, indexpath : Int) {
        self.item = item
        imageProduct.image = UIImage(named: "icon_placeholder_m")
        imageProduct.backgroundColor = UIColor(red:0.71, green:0.71, blue:0.71, alpha:1.0)
        let stringEncode = item.imageUrl.base64Encoded()!
        DataManager.getImageInDirectory(pathDirectory: "images", nameFile: stringEncode) { (image, name) in
            self.handleFinishLoadImage(name: name, image: image)
        }
        nameProduct.text = item.name
        skuProduct.text = item.id
        //skuProduct.layer.borderWidth = 0.4
        //qtyProduct.layer.borderWidth = 0.4
        qtyProduct.text = String(item.quantity)
        let priceString = "$"+item.price!
        priceProduct.text = priceString
        priceProduct.textColor = UIColor(red:0.09, green:0.57, blue:0.53, alpha:1.0)
        if(indexpath % 2 == 0) {
            viewCell1.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
            viewCell2.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
//            qtyProduct.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//            priceProduct.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        }
        else{
            viewCell2.backgroundColor = UIColor.white
            viewCell1.backgroundColor = UIColor.white
//            qtyProduct.backgroundColor = UIColor.white
//            priceProduct.backgroundColor = UIColor.white
        }
    }

    func handleFinishLoadImage(name: String, image: UIImage){
        DispatchQueue.main.async {
            guard self.item?.imageUrl.base64Encoded() == name else {
                return
            }
            self.imageProduct.image = image
            //image.size = imageProduct.siz
        }
    }
}
