//
//  DataFetching.swift
//  AppStoreViewer
//
//  Created by Tom Hays on 17/10/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import Foundation

public protocol DataFetching {
    func fetchData(url: URL, completion: @escaping (Data?, Error?) -> Void)
}

extension DataFetching {
    public func fetchData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }.resume()
    }
}
