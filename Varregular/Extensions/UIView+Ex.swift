//
//  UIView+Ex.swift
//  Varregular
//
//  Created by Антон Баландин on 13.03.24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
}
