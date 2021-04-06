//
//  UIView+Ex.swift
//  WeatherForInnovise
//
//  Created by Hellizar on 6.04.21.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
}
