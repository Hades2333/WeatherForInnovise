//
//  UIStackView+Ex.swift
//  WeatherForInnovise
//
//  Created by Hellizar on 6.04.21.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
