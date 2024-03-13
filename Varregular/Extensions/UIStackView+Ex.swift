//
//  UIStackView+Ex.swift
//  Varregular
//
//  Created by Антон Баландин on 13.03.24.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
