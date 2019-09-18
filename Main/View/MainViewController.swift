//
//  MainViewController.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/9/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainViewProtocol, UICollectionViewDataSource, UICollectionViewDelegate {

    var presenter: MainPresenterProtocol?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var contrainWidth: NSLayoutConstraint!
    @IBOutlet weak var gridViewButton: UIButton!
    @IBOutlet weak var listViewButton: UIButton!

    var cellString = "GridCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        MainRouter.createMainModule(view: self)
        presenter?.displayDefault()
        // Do any additional setup after loading the view.
       
        collectionView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        setUI()
    }
    @IBAction func gridViewOnTap(_ sender: Any) {
        cellString = "GridCell"
        gridViewButton.setImage(UIImage(named: "icon-grid-active"), for: .normal)
        listViewButton.setImage(UIImage(named: "icon-list-normal"), for: .normal)
        collectionView.reloadData()
    }
    @IBAction func listViewOnTap(_ sender: Any) {
        cellString = "ListCell"
        gridViewButton.setImage(UIImage(named: "icon-grid-normal"), for: .normal)
        listViewButton.setImage(UIImage(named: "icon-list-active"), for: .normal)
        collectionView.reloadData()
    }
    
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
        gridViewButton.setImage(UIImage(named: "icon-grid-active"), for: .normal)
        listViewButton.setImage(UIImage(named: "icon-list-normal"), for: .normal)
        //collectionView.backgroundColor = UIColor(red:0.76, green:0.95, blue:0.95, alpha:1.0)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell!
        
        
        switch cellString {
        case "ListCell":
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellString, for: indexPath) as! ListCollectionViewCell
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellString, for: indexPath) as! GridCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
                    }
        if(indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            
        }
        else{
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        switch cellString {
        case "ListCell":
            let listCell = cell as! ListCollectionViewCell
            listCell.fill(item: items[indexPath.row], indexpath: indexPath.row)
            
        default:
            let gridCell = cell as! GridCollectionViewCell
            gridCell.fill(item: items[indexPath.row], indexpath: indexPath.row)
        }
   
    }
}
extension MainViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if cellString == "ListCell"{
            let width = UIScreen.main.bounds.width
            return CGSize(width: width, height: 56)
        }
        else{
            return CGSize(width: 129, height: 112)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if(cellString == "ListCell"){
        return 0
        }else{
            return 10
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if(cellString == "ListCell"){
            return 0
        }else{
            return 10
        }
    }
    
}
