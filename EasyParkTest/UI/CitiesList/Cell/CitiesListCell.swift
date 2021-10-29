//
//  CitiesListCell.swift
//  EasyParkTest
//
//  Created by Vitalii Kizlov on 29.10.2021.
//

import UIKit

extension UITableViewCell {
    class var identifier: String {
        return String(describing: self)
    }
}

class CitiesListCell: UITableViewCell {
    
    private let citiesListCellView = CitiesListCellView()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup ContentView
    
    private func setupContentView() {
        contentView.addSubview(citiesListCellView)
        citiesListCellView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            citiesListCellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            citiesListCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            citiesListCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            citiesListCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Setup
    
    public func setup(with viewModel: CityViewModel) {
        citiesListCellView.titleLabel.text = viewModel.cityName
        //exchangeRateTableViewCellView.valueLabel.text = String(describing: viewModel.exchangeRateValue)
    }
}
