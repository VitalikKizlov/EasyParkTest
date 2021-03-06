//
//  CityViewModel.swift
//  EasyParkTest
//
//  Created by Vitalii Kizlov on 29.10.2021.
//

import Foundation
import CoreLocation

struct CityViewModel {
    
    let cityName: String
    let coordinate: CLLocation
    var polygonCoordinates: [CLLocationCoordinate2D] = []
    var distanceToUser = ""
    
    // MARK: - Init
    
    init(city: City) {
        self.cityName = city.name
        self.coordinate = CLLocation(latitude: city.lat, longitude: city.lon)
        configurePolygonCoordinates(from: city)
    }
    
    mutating func configurePolygonCoordinates(from city: City) {
        let token = city.points.components(separatedBy: ",")
        for i in token {
            let stringCoordinates = i.components(separatedBy: " ")
            let stringLat = stringCoordinates.first ?? "0"
            let lat = Double(stringLat) ?? 0
            let stringLon = stringCoordinates.last ?? "0"
            let lon = Double(stringLon) ?? 0
            /*
             Not sure why but coordinates are swapped in json
             */
            let coordinate = CLLocation(latitude: lon, longitude: lat).coordinate
            polygonCoordinates.append(coordinate)
        }
    }
    
    mutating func calculateDistanceToUser(_ userLocation: CLLocation?) {
        if let location = userLocation {
            let distance = String(describing: location.distance(from: coordinate))
            distanceToUser = "\(distance) meters"
        } else {
            distanceToUser = "Can't calculate distance"
        }
    }
}
