//
//  CategoryButton.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/20/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class CategoryButton: UIButton {
    var imageCategory: UIImageView!
    var imageColor: UIImageView!
    var buttonLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageCategory = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        imageColor = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        buttonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width , height: frame.height))
        buttonLabel.textAlignment = NSTextAlignment.center
        buttonLabel.textColor = UIColor.white
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func displayCategory(category: CategoryModel) {
        do{
            imageCategory.image = UIImage(data: try Data(contentsOf: URL(string: category.imageUrl) ?? URL(string: "https://res.cloudinary.com/teepublic/image/private/s--zHtQBp1P--/t_Preview/b_rgb:ffffff,c_lpad,f_jpg,h_630,q_90,w_1200/v1537945289/production/designs/3214340_0.jpg")!)) ?? UIImage(named: "icon-back")
        }catch{
            print(error.localizedDescription)
        }
        imageColor.backgroundColor = UIColor(red: 0.75, green: 0.24, blue: 0.24, alpha: 0.5)
        buttonLabel.text = category.name
    }
    func setUp()  {
        self.addSubview(imageCategory)
        imageCategory.addSubview(imageColor)
        imageColor.addSubview(buttonLabel)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
