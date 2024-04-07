//
//  CornerRadiusImageView.swift
//  iTunes
//
//  Created by youngjoo on 4/7/24.
//

import UIKit

class CornerRadiusImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setCornerRadius()
    }
}
