//
//  CornerRedius.swift
//  iTunes
//
//  Created by youngjoo on 4/7/24.
//

import UIKit

extension UIView {
    func setCornerRadius() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
    }
}
