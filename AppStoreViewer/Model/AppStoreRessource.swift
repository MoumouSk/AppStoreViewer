//
//  AppStoreRessource.swift
//  AppStoreViewer
//
//  Created by Tom Hays on 17/10/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import Foundation

public class AppStoreRessources : DataFetching {
    
    private struct ServerResponse: Decodable {
        let feed: Feed
    }
    
    private struct Feed: Decodable {
        let entry: [App]
    }
    
    public func getTopApps(top: Int, completion: @escaping ([App], Error?) -> Void) {
        
        let urlString = "https://itunes.apple.com/fr/rss/toppaidapplications/limit=\(top)/json"
        let url = URL(string: urlString)
        
        fetchData(url: url!) { (data, dataError) in
            var apps = [App]()
            var parseError = dataError
            
            defer {
                completion(apps, parseError)
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let serverResponse = try jsonDecoder.decode(ServerResponse.self, from: data)
                apps = serverResponse.feed.entry
            }
            catch {
                parseError = error
            }
            
        }
    }
}
