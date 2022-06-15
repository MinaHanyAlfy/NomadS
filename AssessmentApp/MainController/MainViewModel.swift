//
//  MainViewModel.swift
//  AssessmentApp
//
//  Created by John Doe on 2022-06-15.
//

import Foundation


protocol MainViewModelProtocol {
    func productsResult()
}
public class MainViewModel: MainViewModelProtocol {
    
    
    var keys : [String] = []{
        didSet{
            
                //                CoreDataManager.shared.saveProducts(products: self.products ?? [])
                DispatchQueue.main.async {
                    self.view.ProductsSuccess(products: self.products,keys: self.keys)
                }
                
            
        }
    }
    var products: Products = [:]
    
    weak private var view: MainViewProtocol!
    
    init(view: MainViewProtocol) {
        self.view = view
    }
    
    
}
//Function Extenison
extension MainViewModel{
    
    func productsResult() {
        NetworkServiceMock.shared.getResults(APICase: .getDefault,decodingModel: Products.self) { [weak self] (response) in
            switch response{
                
            case .success(let data):
                self?.products = data
                self?.keys = self?.products.keys.sorted() ?? []
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
}
