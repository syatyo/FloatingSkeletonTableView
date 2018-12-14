//
//  ITunesClient.swift
//  FloatingSkeletonTableView
//
//  Created by 山田良治 on 2018/12/15.
//  Copyright © 2018 山田良治. All rights reserved.
//

import Foundation
import SwiftyXMLParser

final class ITunesClient {
    
    // 面倒なのでエラーハンドリングは無視
    func fetchTopMovies(completion: @escaping (([Movie]) -> Void)) {
        let url = URL(string: "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topMovies/sf=143462/xml")!
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            let xml = XML.parse(data!)
            let movies = MovieTranslater.translate(from: xml)
            completion(movies)
        }
        task.resume()
    }
    
}

struct MovieTranslater {
    
    static func translate(from xml: XML.Accessor) -> [Movie] {
        let entries = xml["feed"]["entry"]
        return entries.map {
            let imageItem =  $0["im:image"].first(where: { $0.attributes["height"] == "170" })!
            let thumbnailURL = URL(string: imageItem.text!)!
            let description = $0["summary"].text!
            return Movie(thumbnailURL: thumbnailURL, description: description)
        }
    }
    
}

struct Movie {
    let thumbnailURL: URL
    let description: String
}
