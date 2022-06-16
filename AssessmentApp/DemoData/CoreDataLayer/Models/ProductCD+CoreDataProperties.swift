//
//  ProductCD+CoreDataProperties.swift
//  AssessmentApp
//
//  Created by John Doe on 2022-06-16.
//
//

import Foundation
import CoreData


extension ProductCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductCD> {
        return NSFetchRequest<ProductCD>(entityName: "ProductCD")
    }

    @NSManaged public var barcode: String?
    @NSManaged public var costPrice: Int64
    @NSManaged public var id: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var key: String?
    @NSManaged public var name: String?
    @NSManaged public var productsDescription: String?
    @NSManaged public var retailPrice: Int64

}

extension ProductCD : Identifiable {

}
