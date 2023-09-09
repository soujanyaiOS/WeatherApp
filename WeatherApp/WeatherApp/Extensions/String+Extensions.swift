//
//  String+Extensions.swift
//  WeatherApp
//
//  Created by soujanya Balusu on 09/09/23.
//

import Foundation
import UIKit

extension String {
    var asURL: URL? {
        return URL(string: self)
    }

}
