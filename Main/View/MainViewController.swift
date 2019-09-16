//
//  MainViewController.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/9/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainViewProtocol, UICollectionViewDataSource {

    var presenter: MainPresenterProtocol?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        MainRouter.createMainModule(view: self)
        presenter?.displayDefault()
        // Do any additional setup after loading the view.
        setUI()
    }
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var contrainWidth: NSLayoutConstraint!
    func showError() {
        
    }
    
    func displayCategory(categories: [CategoryModel]) {
        for index in 0..<categories.count{
            let button = UIButton(frame: CGRect(x:60 + (index * 110) , y:8 , width: 100, height: 50))
            button.layer.cornerRadius = 20
            do{
                button.setBackgroundImage(UIImage(data: try Data(contentsOf: URL(string: categories[index].imageUrl) ?? URL(string: "https://res.cloudinary.com/teepublic/image/private/s--zHtQBp1P--/t_Preview/b_rgb:ffffff,c_lpad,f_jpg,h_630,q_90,w_1200/v1537945289/production/designs/3214340_0.jpg")!)) ?? UIImage(named: "icon-back") , for: .normal)
            }catch{
                print(error.localizedDescription)
            }
            button.clipsToBounds = true
            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitle(categories[index].name, for: .normal)
            button.titleLabel?.textAlignment = NSTextAlignment.center
            contentView.addSubview(button)
            contrainWidth.constant = button.frame.maxX - UIScreen.main.bounds.width + 10
        }
        
    }
    var items : [ProductModel] = []
    func displayProduct(products: [ProductModel]) {
        items = products
        collectionView.dataSource = self
    }
    func setUI() {
        backButton.layer.cornerRadius = 0.5 * backButton.bounds.size.width
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCollectionViewCell
        do{
        cell.imageProduct.image = UIImage(data: try Data(contentsOf: URL(string: items[indexPath.row].imageUrl) ?? URL(string: "https://res.cloudinary.com/teepublic/image/private/s--zHtQBp1P--/t_Preview/b_rgb:ffffff,c_lpad,f_jpg,h_630,q_90,w_1200/v1537945289/production/designs/3214340_0.jpg")!))
        }catch{
            print(error.localizedDescription)
        }
        cell.nameProduct.text = items[indexPath.row].name
        return cell
    }
    
}
