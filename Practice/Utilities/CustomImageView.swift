//
//  CustomImageView.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 2/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    var lastUrlUsedToLoadImage: String?

    func loadImage(urlString: String) {
        
        self.image = nil
        
          guard let url = URL(string: urlString) else { return }
                  lastUrlUsedToLoadImage = urlString
        
        
        if let cacheImage = imageCache[urlString] {
            self.image = cacheImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                print("Failed to fetch ImageData:", err)
                return
            }
            
            if url.absoluteString != self.lastUrlUsedToLoadImage {
                return
            }
            
            guard let dataImage = data else { return }
            
            let imagePost = UIImage(data: dataImage)
            
            imageCache[url.absoluteString] = imagePost
            
            
            DispatchQueue.main.async {
                self.image = imagePost
            }
                  }.resume()
    }

}
