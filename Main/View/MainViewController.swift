//
//  MainViewController.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/9/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainViewProtocol {
    var presenter: MainPresenterProtocol?
    
    func displayCategory(category: [Category]?) {
        
    }
    
    func displayProduct(prod: [Product]?) {
        
    }
    
    func showError() {
        
    }
    

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        MainRouter.createMainModule(view: self)
        presenter?.displayDefault()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
