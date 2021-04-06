//
//  Box.swift
//  WeatherForInnovise
//
//  Created by Hellizar on 6.04.21.
//

import Foundation

class Box<T> {

    typealias Listener = (T) -> ()

    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }

    init(_ value: T) {
        self.value = value
    }
}
