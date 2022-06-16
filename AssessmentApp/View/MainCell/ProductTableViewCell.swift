//
//  ProductTableViewCell.swift
//  AssessmentApp
//
//  Created by John Doe on 2022-06-15.
//

import UIKit
class ProductTableViewCell: UITableViewCell {
    let coreDataManager = CoreDataManager.shared
    func didTapPlus(product: Product, key: String) {
        coreDataManager.saveProduct(product: product, key: key)
    }
    
    private var product: Product?
    private var key: String?
    @IBOutlet weak var productImageView: UIImageView!
  
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
   
    public func handleCell(product: Product,key: String){
        if let price = product.retailPrice ?? product.costPrice{
            priceLabel.text = "\(price)$"
        }
        
        nameLabel.text = product.name ?? ""
        downloadImage(from: URL(string: product.imageURL ?? "https://www.dmplayhouse.com/wp-content/uploads/2019/12/13-512.png")!)
        self.product = product
        self.key = key
    }
    
    //Adding to cart
    @IBAction func plusAction(_ sender: Any) {
        guard let product = product else {return}
        guard let key = key else {return}
        print(key,product)
        coreDataManager.saveProduct(product: product, key: key)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        priceLabel.text = nil
        productImageView.image = nil
    }
    
    
    
}
extension ProductTableViewCell{
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
