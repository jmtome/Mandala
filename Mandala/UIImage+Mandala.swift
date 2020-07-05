//
//  UIImage+Mandala.swift
//  Mandala
//
//  Created by Juan Manuel Tome on 05/07/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

enum ImageResource: String {
    case angry
    case confused
    case crying
    case goofy
    case happy
    case meh
    case sad
    case sleepy
}

extension UIImage {

    convenience init(resource: ImageResource) {
        self.init(named: resource.rawValue)!
    }
}

