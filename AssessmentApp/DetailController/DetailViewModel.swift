//
//  DetailViewModel.swift
//  AssessmentApp
//
//  Created by John Doe on 2022-06-15.
//

import Foundation
protocol DetailViewModelProtocol{
    func productResult(product: Product)
}
public class DetailViewModel: DetailViewModelProtocol{
//    var key : String?
    var product: Product?{
        didSet{
         
                DispatchQueue.main.async {
                    guard let product = self.product else {
                        return
                    }

                    self.view.ProductSuccess(product: product)
                }
                
            }
        
    }
    
    weak private var view: DetailViewProtocol!
    
    init(view: DetailViewProtocol){
        self.view = view
    }
    
    
    
}
extension DetailViewModel{
    
    func productResult(product: Product) {
        self.product = product
    }
}
