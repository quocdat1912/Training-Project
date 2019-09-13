//
//  MainInteractor.swift
//  Training Project
//
//  Created by Nguyen Quoc Dat on 9/11/19.
//  Copyright © 2019 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

class MainInteractor : MainInteractorProtocol {
    var presenter: MainPresenterProtocol?
    
    var Api: ApiServiceProtocol?
    
    var datamanager: DataManagerProtocol?
    
    func parseCategoryData(data: Data?) ->[CategoryModel] {
        var cate: [CategoryModel] = []
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: [])
            //print(json)
            guard let jsonDiction = json as? [String: Any] else {return cate}
            let item = jsonDiction["items"]
            //print(item!)
            let realData = try! JSONSerialization.data(withJSONObject: item!, options: .prettyPrinted)
            let decoder = JSONDecoder()
            var cateTry = try decoder.decode([CategoryModel].self, from: realData)
            print(cateTry.count)
            for i in 0..<cateTry.count{
                cateTry[i].page = jsonDiction["page"] as? Int
            }
            let page = jsonDiction["page"] as! Int
            let maxpage = jsonDiction["maxPage"] as! Int
            //SavePage first time
            var pages : [Page] = []
            try datamanager?.fetchPage(handler: { (nsmanagedobject) in
                pages = nsmanagedobject as! [Page]
            })
            if pages.count < 2{
                try datamanager?.savePage(type: "category", maxPage: maxpage, currentPage: page, handler: { (nsmanagedobject) in
                })
            }
            cate = cateTry
        }catch{
            print(error.localizedDescription)
        }
        return cate
    }
    
    func parseProductData(data: Data?) -> [ProductModel]{
        var prod : [ProductModel] = []
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: [])
            //print(json)
            guard let jsonDiction = json as? [String: Any] else {return prod }
            let item = jsonDiction["items"]
            //print(item!)
            let realData = try! JSONSerialization.data(withJSONObject: item!, options: .prettyPrinted)
            let decoder = JSONDecoder()
            var prodTry = try decoder.decode([ProductModel].self, from: realData)
            print(prodTry.count)
            for i in 0..<prodTry.count{
                prodTry[i].page = jsonDiction["page"] as? Int
            }
            let page = jsonDiction["page"] as! Int
            let maxpage = jsonDiction["maxPage"] as! Int
            //SavePage first time
            var pages : [Page] = []
            try datamanager?.fetchPage(handler: { (nsmanagedobject) in
                pages = nsmanagedobject as! [Page]
            })
            if pages.count < 2{
                try datamanager?.savePage(type: "product", maxPage: maxpage, currentPage: page, handler: { (nsmanagedobject) in
                })
            }
            prod = prodTry
        }catch{
            print(error.localizedDescription)
        }
        return prod
    }
    
    var data: Data?
    
    func retrieveData() {
        let token = UserDefaults.standard.string(forKey: "token")!
        //If false -> get default 
        if checkDataBase() == false {
            let productString = "https://api.unityspace.space/v0/stores/3/products?page=1&limit=100"
            let categoryString = "https://api.unityspace.space/v0/stores/3/catalogs?page=1&limit=100"
            //get Product and Save products to database
            Api?.get(urlString: productString, token: token, completeHandler: { (data, error) in
                let products = self.parseProductData(data: data)
                do{ try self.datamanager?.saveProduct(products: products, handler: { (nsmanagedobject) in

                })
                }catch{
                    print(error.localizedDescription)
                }
            })
            //get Category and save to database
            Api?.get(urlString: categoryString, token: token, completeHandler: { (data, error) in
                let categories = self.parseCategoryData(data: data)
                do{
                    try self.datamanager?.saveCategory(categories: categories, handler: { (nsmanagedobject) in
                        
                    })
                }catch{
                    print(error.localizedDescription)
                }
                self.didSavePage()
            })
        }else{
            didSavePage()
        }
    }
//    func didSavePage (){
//        let token = UserDefaults.standard.string(forKey: "token")!
//        var productPage: Int = 0
//        var categoryPage: Int = 0
//        //var productString = "https://api.unityspace.space/v0/stores/3/products?page=\(productPage)&limit=100"
//        //var categoryString = "https://api.unityspace.space/v0/stores/3/catalogs?page=\(categoryPage)&limit=100"
//        var pages : [Page] = []
//
//        do{
//            try datamanager?.fetchPage(handler: { (nsmanagedobject) in
//                pages = nsmanagedobject as! [Page]
//            })
//            print("number of pages: \(pages.count)")
//            for page in pages{
//                if page.type == "product" {
//                    //print("get here")
//                    if page.current_page < page.max_page{
//                        for i in page.current_page+1...page.max_page{
//                            productPage = Int(i)
//                            let productString = "https://api.unityspace.space/v0/stores/3/products?page=\(productPage)&limit=100"
//                            Api?.get(urlString: productString, token: token, completeHandler: { (data, error) in
//                                let products = self.parseProductData(data: data)
//                                do {
//                                    try self.datamanager?.saveProduct(products: products, handler: { (nsmanagedobject) in
//
//                                    })
//                                    page.current_page = i
//                                    try self.datamanager?.updatePage(page: page, handLer: { (nsmanagedobject) in
//                                    })
//                                    if page.current_page == page.max_page {
//                                        self.saveProductSuccess()
//                                    }
//                                }
//                                catch {
//                                    print(error.localizedDescription)
//                                }
//
//                            })
//
//                        }
//                    }
//                    else{
//                        saveProductSuccess()
//                    }
//
//                }
//                else{
//                    if page.current_page < page.max_page{
//                        for i in page.current_page+1...page.max_page{
//                            categoryPage = Int(i)
//                            let categoryString = "https://api.unityspace.space/v0/stores/3/catalogs?page=\(categoryPage)&limit=100"
//                            Api?.get(urlString: categoryString, token: token, completeHandler: { (data, error) in
//                                let categories = self.parseCategoryData(data: data)
//                                do{
//                                    try self.datamanager?.saveCategory(categories: categories, handler: { (nsmanagedobject) in
//
//                                    })
//                                    page.current_page = i
//                                    try self.datamanager?.updatePage(page: page, handLer: { (nsmanagedobject) in
//                                    })
//                                    if page.current_page == page.max_page {
//                                        self.saveProductSuccess()
//                                    }
//                                }catch{
//                                    print(error.localizedDescription)
//                                }
//                            })
//                        }
//                    }
//                    else{
//                        saveCategorySuccess()
//                    }
//                }
//            }
//        }catch{
//            print(error.localizedDescription)
//        }
//
//    }
    
    func didSavePage()  {
        productSaver()
        categorySaver()
    }
    
    
    
    /// Description Check current page then get data from sever with a nextPage and save it to Database till current page = max page
    func productSaver(){
        let token = UserDefaults.standard.string(forKey: "token")!
        var pages : [Page] = []
        do{
            try datamanager?.fetchPage(handler: { (nsmanagedobject) in
                pages = nsmanagedobject as! [Page]
            })
        }catch{
            print(error.localizedDescription)
        }
        var page = Page()
        for i in pages{
            if(i.type! == "product"){
                page = i
            }
        }
        //var productPage = page.current_page
        if page.current_page < page.max_page{

                //productPage = Int(i)
                let productString = "https://api.unityspace.space/v0/stores/3/products?page=\(page.current_page + 1)&limit=100"
                Api?.get(urlString: productString, token: token, completeHandler: { (data, error) in
                    let products = self.parseProductData(data: data)
                    do {
                        try self.datamanager?.saveProduct(products: products, handler: { (nsmanagedobject) in
                            
                        })
                        page.current_page += 1
                        try self.datamanager?.updatePage(page: page, handLer: { (nsmanagedobject) in
                        })
                        self.productSaver()
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                    
                })
                
            
        }
        else{
            saveProductSuccess()
        }
    }
    
    func categorySaver()  {
        let token = UserDefaults.standard.string(forKey: "token")!
        var pages : [Page] = []
        do{
            try datamanager?.fetchPage(handler: { (nsmanagedobject) in
                pages = nsmanagedobject as! [Page]
            })
        }catch{
            print(error.localizedDescription)
        }
        
        var page: Page = Page()
        for i in pages{
            if(i.type! == "category"){
                page = i
            }
        }
        //var productPage = page.current_page
        if page.current_page < page.max_page{
            
            //productPage = Int(i)
            let categoryString = "https://api.unityspace.space/v0/stores/3/catalogs?page=\(page.current_page + 1)&limit=100"
            Api?.get(urlString: categoryString, token: token, completeHandler: { (data, error) in
                let categories = self.parseCategoryData(data: data)
                do {
                    try self.datamanager?.saveCategory(categories: categories, handler: { (nsmanagedobject) in
                        
                    })
                    page.current_page += 1
                    try self.datamanager?.updatePage(page: page, handLer: { (nsmanagedobject) in
                    })
                    self.productSaver()
                }
                catch {
                    print(error.localizedDescription)
                }
                
            })
            
            
        }
        else{
            saveCategorySuccess()
        }
    }
    
    func checkDataBase() -> Bool {
        var check : Bool?
        do {
            
            try datamanager?.fetchPage(handler: { (nsmanagedobject) in
                if nsmanagedobject == []{
                    check = false
                }
                else {
                    check = true
                }
                
            })
            
        } catch  {
            print(error.localizedDescription)
        }
        return check!
    }
    
    func saveProductSuccess (){
        do{
            try datamanager?.fetchProduct(handler: { (nsmanagerobject) in
                let products = nsmanagerobject as! [Product]
                presenter?.didGetProducts(products: products)
            })
        }catch{
            print(error.localizedDescription)
        }
    }
    func saveCategorySuccess()  {
        do{
            try datamanager?.fetchCategory(handler: { (nsmanagedobject) in
                let categories = nsmanagedobject as! [Category]
                presenter?.didGetCategories(categories: categories)
            })
        }catch{
            print(error.localizedDescription)
        }
    }
    func deleteDataBase() {
        datamanager?.deleteAllData(entityName: "Product")
        datamanager?.deleteAllData(entityName: "Page")
        datamanager?.deleteAllData(entityName: "Category")
    }
    
}
