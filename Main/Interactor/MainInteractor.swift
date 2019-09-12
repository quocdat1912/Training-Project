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
            try datamanager?.savePage(type: "category", maxPage: maxpage, currentPage: page, handler: { (nsmanagedobject) in
                
            })
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
            print(prod.count)
            for i in 0..<prodTry.count{
                prodTry[i].page = jsonDiction["page"] as? Int
            }
            let page = jsonDiction["page"] as! Int
            let maxpage = jsonDiction["maxPage"] as! Int
            //SavePage first time
            try datamanager?.savePage(type: "product", maxPage: maxpage, currentPage: page, handler: { (nsmanagedobject) in
                
            })
            prod = prodTry
        }catch{
            print(error.localizedDescription)
        }
        return prod
    }
    
    var data: Data?
    
    func retrieveData() {
        let token = UserDefaults.standard.string(forKey: "token")!
        
        if checkDataBase() == false{
            let productString = "https://api.unityspace.space/v0/stores/3/products?page=0&limit=100"
            let categoryString = "https://api.unityspace.space/v0/stores/3/catalogs?page=1&limit=100"
            //get Product
            Api?.get(urlString: productString, token: token, completeHandler: { (data, error) in
                let products = self.parseProductData(data: data)
                do{ try self.datamanager?.saveProduct(products: products, handler: { (nsmanagedobject) in
                    
                })
                }catch{
                    print(error.localizedDescription)
                }
            })
            //get Category
            Api?.get(urlString: categoryString, token: token, completeHandler: { (data, error) in
                let categories = self.parseCategoryData(data: data)
                do{
                    try self.datamanager?.saveCategory(categories: categories, handler: { (nsmanagedobject) in
                        
                    })
                }catch{
                    print(error.localizedDescription)
                }
            })
        }
        else{
            var productPage: Int = 0
            var categoryPage: Int = 0
            //var productString = "https://api.unityspace.space/v0/stores/3/products?page=\(productPage)&limit=100"
            //var categoryString = "https://api.unityspace.space/v0/stores/3/catalogs?page=\(categoryPage)&limit=100"
            var pages : [Page] = []
            do{
                try datamanager?.fetchPage(handler: { (nsmanagedobject) in
                    pages = nsmanagedobject as! [Page]
                })
                for page in pages{
                    if page.type == "product" {
                        if page.current_page < page.max_page{
                            for i in page.current_page...page.max_page{
                                productPage = Int(i)
                                let productString = "https://api.unityspace.space/v0/stores/3/products?page=\(productPage)&limit=100"
                                Api?.get(urlString: productString, token: token, completeHandler: { (data, error) in
                                    let products = self.parseProductData(data: data)
                                    do {
                                        try self.datamanager?.saveProduct(products: products, handler: { (nsmanagedobject) in
                                            
                                        })
                                    }
                                    catch {
                                        print(error.localizedDescription)
                                    }
                                })
                            }
                            saveProductSuccess()
                        }
                        else{
                            saveProductSuccess()
                        }
                        
                    }
                    else{
                        if page.current_page < page.max_page{
                            for i in page.current_page...page.max_page{
                                categoryPage = Int(i)
                                let categoryString = "https://api.unityspace.space/v0/stores/3/catalogs?page=\(categoryPage)&limit=100"
                                Api?.get(urlString: categoryString, token: token, completeHandler: { (data, error) in
                                    let categories = self.parseCategoryData(data: data)
                                    do{
                                        try self.datamanager?.saveCategory(categories: categories, handler: { (nsmanagedobject) in
                                            
                                        })
                                    }catch{
                                        print(error.localizedDescription)
                                    }
                                })
                            }
                            saveCategorySuccess()
                        }
                        else{
                            saveCategorySuccess()
                        }
                        
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }
        
        
        //        do {
        //            try datamanager?.fetchCategory(handler: { (nsmanagedobject) in
        //                print(nsmanagedobject!)
        //                if nsmanagedobject == [] {
        //                    let string = "https://api.unityspace.space/v0/stores/3/catalogs?page=1&limit=100"
        //                    Api?.get(urlString: string, token: UserDefaults.standard.string(forKey: "token")!, completeHandler: { (data, error) in
        //                        print(String(data: data!, encoding: .utf8)!)
        //                        //print(error!)
        //                        self.data = data
        //                        self.parseCategoryData(data: data)
        //                    })
        //                }
        //            })
        //            try datamanager?.fetchProduct(handler: { (nsman) in
        //                <#code#>
        //            })
        //
        //        }
        //        catch {
        //            print(error.localizedDescription)
        //        }
    }
    func checkDataBase() -> Bool {
        var check : Bool?
        do {
            
            try datamanager?.fetchPage(handler: { (nsmanagedobject) in
                if nsmanagedobject == []{
                    check = false
                }
                else {
                    check = false
                }
                
            })
            
        } catch  {
            print(error.localizedDescription)
        }
        return check!
    }
    func saveProductSuccess (){
        
    }
    func saveCategorySuccess()  {
        
    }
    
}
