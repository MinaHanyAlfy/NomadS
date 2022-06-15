//
//  ProductTableViewCell.swift
//  AssessmentApp
//
//  Created by John Doe on 2022-06-15.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 12
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    public func handleCell(product: Product){
        if let price = product.retailPrice {
            priceLabel.text = "\(price)$"
        }
        if let price = product.costPrice {
            priceLabel.text = "\(price)$"
        }
        nameLabel.text = product.name ?? ""
        downloadImage(from: URL(string: product.imageURL ?? "https://www.dmplayhouse.com/wp-content/uploads/2019/12/13-512.png")!)
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
