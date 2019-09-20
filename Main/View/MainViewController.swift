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
    @IBOutlet weak var directionLabel: UILabel!
    
    var cellString = "GridCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        MainRouter.createMainModule(view: self)
        
        // Do any additional setup after loading the view.
       
        collectionView.delegate = self
    }
    override func viewDidLayoutSubviews() {
        
        //super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        setUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        presenter?.displayDefault()
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
    @IBAction func backButton(_ sender: Any) {
        presenter?.view?.displayProduct(products: (presenter?.getProducts())!)
        let quantity = presenter?.getProducts().count
        let string = "All fashion " + "(" + String(quantity!) + ")"
        let atributedString = NSMutableAttributedString(string: string)
        atributedString.setColorForText(textForAttribute: "All fashion", withColor: UIColor(red:0.09, green:0.57, blue:0.53, alpha:1.0))
        directionLabel.attributedText = atributedString
    }
    
    func showError() {
        
    }
    
    func displayCategory(categories: [CategoryModel]) {
//        for index in 0..<categories.count{
//            let button = UIButton(frame: CGRect(x:60 + (index * 110) , y:8 , width: 100, height: 50))
//            button.layer.cornerRadius = 20
//            do{
//                button.setImage(UIImage(data: try Data(contentsOf: URL(string: categories[index].imageUrl) ?? URL(string: "https://res.cloudinary.com/teepublic/image/private/s--zHtQBp1P--/t_Preview/b_rgb:ffffff,c_lpad,f_jpg,h_630,q_90,w_1200/v1537945289/production/designs/3214340_0.jpg")!)) ?? UIImage(named: "icon-back") , for: .normal)
//                //button.imageView?.backgroundColor = UIColor(red:0.75, green:0.24, blue:0.24, alpha:1)
//            }catch{
//                print(error.localizedDescription)
//            }
//            button.clipsToBounds = true
//            button.setTitleColor(UIColor.white, for: .normal)
//            button.setTitle(categories[index].name, for: .normal)
//            button.titleLabel?.textAlignment = NSTextAlignment.center
//            //button.layer.borderWidth = 2
//            button.tag = index
//            button.addTarget(self, action: #selector(didCategoriesSelected), for: .touchUpInside)
//            contentView.addSubview(button)
//            contrainWidth.constant = button.frame.maxX - UIScreen.main.bounds.width + 10
//
//        }
        for index in 0..<categories.count{
            let button = CategoryButton(frame: CGRect(x:60 + (index * 110) , y:8 , width: 100, height: 50))
            button.displayCategory(category: categories[index])
            button.tag = index
            button.addTarget(self, action: #selector(didCategoriesSelected), for: .touchUpInside)
            contentView.addSubview(button)
            contrainWidth.constant = button.frame.maxX - UIScreen.main.bounds.width + 10

        }
        
    }
    @objc func didCategoriesSelected (sender : UIButton){
        let tag = sender.tag
        presenter?.displayProductByCatelogy(senderTag: tag)
        let name = presenter?.getCategories()[tag].name!
        let quantity = items.count
        let string = NSMutableAttributedString(string:"All fashion / \(String(describing: name!)) (\(String(describing: quantity)))" )
        string.setColorForText(textForAttribute: name!, withColor: UIColor(red:0.09, green:0.57, blue:0.53, alpha:1.0))
        directionLabel.attributedText = string
        
    }
    
    
    var items : [ProductModel] = []
    
    func displayProduct(products: [ProductModel]) {
        items = products
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    func setUI() {
        backButton.layer.cornerRadius = 0.5 * backButton.bounds.size.width
        gridViewButton.setImage(UIImage(named: "icon-grid-active"), for: .normal)
        listViewButton.setImage(UIImage(named: "icon-list-normal"), for: .normal)
        let quantity = presenter?.getProducts().count
        let string = "All fashion " + "(" + String(quantity!) + ")"
        let atributedString = NSMutableAttributedString(string: string)
        atributedString.setColorForText(textForAttribute: "All fashion", withColor: UIColor(red:0.09, green:0.57, blue:0.53, alpha:1.0))
        directionLabel.attributedText = atributedString
        
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
            cell.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
            
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
            //let width = UIScreen.main.bounds.width
            return CGSize(width: collectionView.frame.width, height: 60)
        }
        else{
            var width = collectionView.bounds.width
            let numberItems = 3
            let totalSpace = 20 + ((numberItems - 1) * 10)
            width = (width - CGFloat(totalSpace))/3
            return CGSize(width: 125, height: 85)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if(cellString == "ListCell"){
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else{
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if(cellString == "ListCell"){
        return 0
        }else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if(cellString == "ListCell"){
            return 0
        }else{
            return 10
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? HeaderReusableView
            sectionHeader?.setUp()
            return sectionHeader!
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if(cellString != "ListCell"){
            return CGSize(width: 0, height: 0)
        }else{
            return CGSize(width: UIScreen.main.bounds.width, height: 40)
        }
    }
}
