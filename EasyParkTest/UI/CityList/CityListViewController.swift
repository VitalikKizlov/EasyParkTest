//
//  ViewController.swift
//  EasyParkTest
//
//  Created by Vitalii Kizlov on 29.10.2021.
//

import UIKit
import Combine

final class CityListViewController: UIViewController {
    
    // MARK: - Internal Properties
    
    private let cityListViewModel = CityListViewModel()
    private (set) var activityIndicator = UIActivityIndicatorView()
    private(set) var cityListViewControllerView = CityListViewControllerView()
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        cityListViewModel.requestLocation()
        bindViewModelToView()
    }

    // MARK: - Setup View
    
    private func setupView() {
        title = "Cities"
        navigationController?.navigationBar.prefersLargeTitles = true
        addCityListViewControllerView()
        addActivityIndicator()
        cityListViewControllerView.tableView.dataSource = self
        cityListViewControllerView.tableView.delegate = self
    }
    
    private func addActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
        self.view.bringSubviewToFront(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    private func addCityListViewControllerView() {
        self.view.addSubview(cityListViewControllerView)
        cityListViewControllerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityListViewControllerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            cityListViewControllerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            cityListViewControllerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            cityListViewControllerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    // MARK: - Private
    
    private func bindViewModelToView() {
        let viewModelStateHandler: (ViewModelState) -> Void = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .inActive:
                self.activityIndicator.isHidden = true
            case .loading:
                self.activityIndicator.startAnimating()
            case .finishedLoading:
                self.activityIndicator.stopAnimating()
            case .error(let error):
                self.presentLocationErrorALert(error)
            }
        }
        
        cityListViewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: viewModelStateHandler)
            .store(in: &subscriptions)
        
        let cityViewModelsValueHandler: ([CityViewModel]) -> Void = { [weak self] _ in
            guard let self = self else { return }
            self.cityListViewControllerView.tableView.reloadData()
        }
        
        cityListViewModel.$cityViewModels
            .receive(on: RunLoop.main)
            .sink(receiveValue: cityViewModelsValueHandler)
            .store(in: &subscriptions)
    }
    
    private func presentLocationErrorALert(_ error: Error) {
        let alert = UIAlertController(title: "Ooops", message: "\(error.localizedDescription). \nLocation access denied", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension CityListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityListViewModel.cityViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityListCell.identifier, for: indexPath) as? CityListCell else {
            return UITableViewCell()
        }
        cell.setup(with: cityListViewModel.cityViewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityViewModel = cityListViewModel.cityViewModels[indexPath.row]
        let cityMapViewController = CityMapViewController(viewModel: cityViewModel)
        show(cityMapViewController, sender: nil)
    }
}

