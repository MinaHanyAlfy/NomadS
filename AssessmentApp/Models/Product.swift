//
//  Product.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import Foundation


// MARK: - ProductsValue
struct Product: Codable {
    let barcode, productsDescription, id: String?
    let imageURL: String?
    let name: String?
    let retailPrice, costPrice: Int?

    enum CodingKeys: String, CodingKey {
        case barcode
        case productsDescription = "description"
        case id
        case imageURL = "image_url"
        case name
        case retailPrice = "retail_price"
        case costPrice = "cost_price"
    }
}

// MARK: ProductsValue convenience initializers and mutators

extension Product {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Product.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        barcode: String?? = nil,
        productsDescription: String?? = nil,
        id: String?? = nil,
        imageURL: String?? = nil,
        name: String?? = nil,
        retailPrice: Int?? = nil,
        costPrice: Int?? = nil
    ) -> Product {
        return Product(
            barcode: barcode ?? self.barcode,
            productsDescription: productsDescription ?? self.productsDescription,
            id: id ?? self.id,
            imageURL: imageURL ?? self.imageURL,
            name: name ?? self.name,
            retailPrice: retailPrice ?? self.retailPrice,
            costPrice: costPrice ?? self.costPrice
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias Products = [String: Product]

extension Dictionary where Key == String, Value == Product {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Products.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
