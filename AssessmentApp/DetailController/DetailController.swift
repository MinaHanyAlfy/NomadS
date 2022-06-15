//
//  DetailController.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func ProductSuccess(product: Product)
}

class DetailController: UIViewController,DetailViewProtocol {
  
    var product : Product? {
        didSet {
            DispatchQueue.main.async {
                guard let product = self.product else {
                    return
                }

                self.viewModel.productResult(product: product)
            }
        }
    }
    private var viewModel: DetailViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailViewModel(view: self)
        // Do any additional setup after loading the view.
    }
    


}
extension DetailController{
    func ProductSuccess(product: Product) {
        self.product = product
    }
    
}
