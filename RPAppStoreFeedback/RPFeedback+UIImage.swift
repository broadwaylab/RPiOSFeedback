//
//  RPImageHelper.swift
//  Pods
//
//  Created by Michael Orcutt on 10/6/17.
//
//

import UIKit

extension UIImage {
    
    public class func starImage(forClass: AnyClass) -> UIImage {
        
        let path = Bundle(for: forClass).path(forResource: "RPiOSFeedback", ofType: "bundle")

        let bundle = Bundle(path: path!)

        let imagePath = bundle?.path(forResource: "star-large", ofType: "png")

        let url = URL(fileURLWithPath: imagePath!)

        let data = try? Data(contentsOf: url)
        
        let image = UIImage(data: data!)?.withRenderingMode(.alwaysTemplate)

        return image!
        
    }
    
}
