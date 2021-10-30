//
//  CityMapViewController.swift
//  EasyParkTest
//
//  Created by Vitalii Kizlov on 30.10.2021.
//

import UIKit
import MapKit

final class CityMapViewController: NiblessViewController {
    
    let viewModel: CityViewModel
    
    init(viewModel: CityViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    private let mapView = MKMapView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        addMap()
        setCityRegion()
    }
    
    private func addMap() {
        self.view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func setCityRegion() {
        let region = MKCoordinateRegion(center: viewModel.coordinate.coordinate, latitudinalMeters: CityViewModel.regionSpanMeters, longitudinalMeters: CityViewModel.regionSpanMeters)
        mapView.setRegion(region, animated: true)
    }
}
