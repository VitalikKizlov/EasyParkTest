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
        
        self.addSubview(titleLabel)
        self.addSubview(valueLabel)
        
        [titleLabel, valueLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: valueLabel.topAnchor, constant: -16),
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            valueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        ])
    }
    
}
