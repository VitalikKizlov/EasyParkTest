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
    private let polygonInset: CGFloat = 10
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        addMap()
        mapView.delegate = self
        drawPolygon()
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
    
    private func drawPolygon() {
        let coordinates = viewModel.polygonCoordinates
        let polygon = MKPolygon(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(polygon)
        
        let polygonRegion = polygon.boundingMapRect
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        mapView.setVisibleMapRect(polygonRegion, edgePadding: insets, animated: true)
    }
}

// MARK: - MKMapViewDelegate

extension CityMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolygonRenderer(overlay: overlay)
        renderer.strokeColor = .red
        renderer.lineWidth = 2
        return renderer
    }
}
