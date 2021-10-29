//
//  ViewController.swift
//  EasyParkTest
//
//  Created by Vitalii Kizlov on 29.10.2021.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    // MARK: - Internal Properties
    
    private let citiesViewModel = CitiesViewModel()
    private (set) var activityIndicator = UIActivityIndicatorView()
    private var subscriptions = Set<AnyCancellable>()

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        citiesViewModel.getCities()
        bindViewModelToView()
    }

    // MARK: - Setup View
    
    private func setupView() {
        title = "Cities"
        navigationController?.navigationBar.prefersLargeTitles = true
        addActivityIndicator()
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
                print(error.localizedDescription)
            }
        }
        
        citiesViewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: viewModelStateHandler)
            .store(in: &subscriptions)
    }

}

