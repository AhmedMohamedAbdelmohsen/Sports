//
//  UIImageFile.swift
//  Sports
//
//  Created by Ahmed on 3/28/21.
//

import UIKit

extension UIImageView{
    func roundedImage(){
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}
