//
//  CitiesListView.swift
//  EasyParkTest
//
//  Created by Vitalii Kizlov on 29.10.2021.
//

import UIKit

class CityListViewControllerView: NiblessView {
    
    private(set) var tableView = UITableView()
    
    // MARK: - Init
    
    override init() {
        super.init()
        setupView()
    }
    
    // MARK: - Private
    
    private func setupView() {
        addTableView()
        setupTableView()
    }
    
    private func addTableView() {
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.register(CitiesListCell.self, forCellReuseIdentifier: CitiesListCell.identifier)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
    }
}
