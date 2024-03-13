//
//  String+Ex.swift
//  Varregular
//
//  Created by Антон Баландин on 13.03.24.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
