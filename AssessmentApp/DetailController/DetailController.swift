//
//  DetailController.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import UIKit

//protocol DetailViewProtocol: AnyObject {
//    func ProductSuccess(product: Product)
//}
//,DetailViewProtocol
class DetailController: UIViewController {
  
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var product : Product? {
        didSet {
            DispatchQueue.main.async { [self] in
                guard let product = self.product else {
                    return
                }
                nameLabel.text = product.name
                descriptionLabel.text = product.productsDescription
                if let price = product.costPrice ?? product.retailPrice {
                priceLabel.text = "\(price)$"
                downloadImage(from: URL(string: product.imageURL ?? "https://www.dmplayhouse.com/wp-content/uploads/2019/12/13-512.png")!)
                }
            }
        }
    }
//    private var viewModel: DetailViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel = DetailViewModel(view: self)
        // Do any additional setup after loading the view.
    }
    


}
extension DetailController{
//    func ProductSuccess(product: Product) {
////        self.product = product
//    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.productImageView.image = UIImage(data: data)
            }
        }
    }

}
