//
//  CartViewModel.swift
//  AssessmentApp
//
//  Created by John Doe on 2022-06-16.
//

import Foundation
protocol CartViewModelProtocol {
    func productsResult()
}
public class CartViewModel: CartViewModelProtocol {
    
    let coreData = CoreDataManager.shared
    var keys : [String] = []{
        didSet{
    
                DispatchQueue.main.async {
                    self.view.ProductsSuccess(products: self.products,keys: self.keys)
                }
                
            
        }
    }
    var products: Products = [:]
    
    weak private var view: CartViewProtocol!
    
    init(view: CartViewProtocol) {
        self.view = view
    }
    
    
}

//Function Extenison
extension CartViewModel{
    

    func productsResult() {
        self.products = coreData.getProducts()
        self.keys = products.keys.sorted()
    }
    
}
