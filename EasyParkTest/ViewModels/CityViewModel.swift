//
//  CityViewModel.swift
//  EasyParkTest
//
//  Created by Vitalii Kizlov on 29.10.2021.
//

import Foundation

struct CityViewModel {
    
    let cityName: String
    let coordinate: Coordinate
    var polygonCoordinates: [Coordinate] = []
    
    init(city: City) {
        self.cityName = city.name
        self.coordinate = Coordinate(latitude: city.lat, longitude: city.lon)
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
            let coordinate = Coordinate(latitude: lat, longitude: lon)
            polygonCoordinates.append(coordinate)
        }
    }
}
