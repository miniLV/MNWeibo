//
//  UIImageView+MNWebImage.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/27.
//  Copyright © 2020 miniLV. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView{
    
    func mn_setImage(urlString: String?, placeholderImage: UIImage?, isAvatar: Bool = false){
        
        guard let urlString = urlString,
            let url = URL(string: urlString) else{
            image = placeholderImage
            return
        }
        
        sd_setImage(with: url, placeholderImage: placeholderImage, options: [], context: nil, progress: nil) { [weak self] (image, _, _, _) in
            
            if isAvatar {
                let avatarImage = image?.mn_avatarImage(size: self?.bounds.size)
                self?.image = avatarImage
            }
        }
    }
}
