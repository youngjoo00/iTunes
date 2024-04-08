//
//  CustomTableView.swift
//  iTunes
//
//  Created by youngjoo on 4/8/24.
//

import UIKit

class CustomTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
