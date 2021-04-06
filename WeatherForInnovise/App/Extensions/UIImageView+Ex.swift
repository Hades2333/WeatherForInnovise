//
//  UIImageView+Ex.swift
//  WeatherForInnovise
//
//  Created by Hellizar on 6.04.21.
//

import UIKit

extension UIImage {
    static func donwload(_ url: String) -> UIImage? {
        guard let fullURL = URL(string: "https://openweathermap.org/img/wn/\(url).png") else {
            return nil
        }
        do {
            let data = try Data(contentsOf: fullURL)
            guard let image = UIImage(data: data) else {
                return nil
            }
            return image.withTintColor(.systemYellow)
        } catch {
            return nil
        }
    }
}
