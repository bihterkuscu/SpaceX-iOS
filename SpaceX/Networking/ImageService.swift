//
//  ImageService.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 15.08.2022.
//

import Foundation
func loadData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
    // Compute a path to the URL in the cache
    let fileCachePath = FileManager.default.temporaryDirectory
        .appendingPathComponent(
            url.lastPathComponent,
            isDirectory: false
        )
    
    // If the image exists in the cache,
    // load the image from the cache and exit
    if let data = Data(contentsOfFile: cachedFile.path) {
        completion(data, nil)
        return
    }
    
    // If the image does not exist in the cache,
    // download the image to the cache
    download(url: url, toFile: cachedFile) { (error) in
        let data = Data(contentsOfFile: cachedFile.path)
        completion(data, error)
    }
}
