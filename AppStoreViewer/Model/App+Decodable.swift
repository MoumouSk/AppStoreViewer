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
    
        let imageContainer = try imagesContainer.nestedContainer(keyedBy: LabelKeys.self)
        thumbImageUrl = try imageContainer.decode(String.self, forKey: LabelKeys.label)
    }
}

public protocol Listable : DataFetching {
    var text: String { get }
    var longText: String { get }
    var imageUrl: String { get }
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
