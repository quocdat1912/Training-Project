//
//  HeaderReusableView.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/19/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
        
    @IBOutlet weak var productText: UILabel!
    @IBOutlet weak var skuText: UILabel!
    @IBOutlet weak var qtyText: UILabel!
    @IBOutlet weak var priceText: UILabel!
    
    func setUp() {
        productText.text = "PRODUCT"
        skuText.text = "SKU"
        qtyText.text = "QUANTITY"
        priceText.text = "PRICE"
    }
    
}
