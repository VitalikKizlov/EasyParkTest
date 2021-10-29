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

class CityListCell: UITableViewCell {
    
    private let cityListCellView = CityListCellView()
    
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
        contentView.addSubview(cityListCellView)
        cityListCellView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityListCellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cityListCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cityListCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cityListCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Setup
    
    public func setup(with viewModel: CityViewModel) {
        cityListCellView.titleLabel.text = viewModel.cityName
        //exchangeRateTableViewCellView.valueLabel.text = String(describing: viewModel.exchangeRateValue)
    }
}
