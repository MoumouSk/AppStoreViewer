//
//  App+Decodable.swift
//  AppStoreViewer
//
//  Created by Tom Hays on 17/10/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import Foundation

extension App: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name = "im:name"
        case summary
        case image = "im:image"
    }
    
    private enum LabelKeys: String, CodingKey {
        case label
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nameContainer = try container.nestedContainer(keyedBy: LabelKeys.self, forKey: .name)
        let summaryContainer = try container.nestedContainer(keyedBy: LabelKeys.self, forKey: .summary)
        var imagesContainer = try container.nestedUnkeyedContainer(forKey: .image)
        name = try nameContainer.decode(String.self, forKey: .label)
        summary = try summaryContainer.decode(String.self, forKey: .label)
        
        var tempThumbImageUrl = ""
        while !imagesContainer.isAtEnd {
            let imageContainer = try imagesContainer.nestedContainer(keyedBy: LabelKeys.self)
            tempThumbImageUrl = try imageContainer.decode(String.self, forKey: LabelKeys.label)
            break
        }
        thumbImageUrl = tempThumbImageUrl
    }
    
    public func getThumbnailFromUrl(urlString: String, completion: @escaping (UIImage?)-> Void) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { data, _, _ in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                completion(image)
            }
        }.resume()
    }
}

public protocol Listable {
    var text: String { get }
    var longText: String { get }
    var imageUrl: String { get }
    func getThumbnailFromUrl(urlString: String, completion: @escaping (UIImage?)-> Void)
    }

extension Listable {
    public func getThumbnailFromUrl(urlString: String, completion: @escaping (UIImage?)-> Void) {}
}

extension App: Listable {
    public var text: String {
        return name
    }
    public var longText: String {
        return summary
    }
    public var imageUrl: String {
        return thumbImageUrl
    }
}
