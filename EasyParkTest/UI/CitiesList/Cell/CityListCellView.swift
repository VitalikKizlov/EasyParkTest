//
//  CitiesListCellView.swift
//  EasyParkTest
//
//  Created by Vitalii Kizlov on 29.10.2021.
//

import UIKit

class CityListCellView: NiblessView {
    
    // MARK: - Internal Properties
    
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    
    // MARK: - Init
    
    override init() {
        super.init()
        setupView()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        valueLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        valueLabel.adjustsFontForContentSizeCategory = true
        valueLabel.textAlignment = .right
        
        self.addSubview(titleLabel)
        self.addSubview(valueLabel)
        
        [titleLabel, valueLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        valueLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -16),
            
            valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            valueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            valueLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            valueLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.3)
        ])
    }
    
}
