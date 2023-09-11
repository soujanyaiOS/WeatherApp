//
//  CustomLabel.swift
//  WeatherApp
//
//  Created by soujanya Balusu on 10/09/23.
//

import UIKit

class CustomLabel: UILabel {
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }
    
    func initializeLabel() {
        self.textAlignment = .left
        self.font = UIFont.systemFont(ofSize: 14)
        self.textColor = UIColor.black
        self.numberOfLines = 0        
    }
    
    
}
