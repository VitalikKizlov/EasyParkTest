//
//  DataResponse.swift
//  EasyParkTest
//
//  Created by Vitalii Kizlov on 29.10.2021.
//

import Foundation

struct DataResponse: Codable {
    let status: String
    let message: String?
    let cities: [City]
}

struct City: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let r: Double
    let points: String
}
