//
//  Pet+Image.swift
//  Pets
//
//  Created by MZiO on 6/2/25.
//

import Foundation

extension Pet {
    
    var imageOffset: CGSize {
        .init(width: imageOffsetX, height: imageOffsetY)
    }
    
    func updateImageOffset(offset: CGSize) {
        imageOffsetX = offset.width
        imageOffsetY = offset.height
    }
    
    func updateImageOffset(x: CGFloat, y: CGFloat) {
        imageOffsetX = x
        imageOffsetY = y
    }
}
