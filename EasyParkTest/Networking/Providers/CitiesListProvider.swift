//
//  CitiesListProvider.swift
//  EasyParkTest
//
//  Created by Vitalii Kizlov on 29.10.2021.
//

import Foundation
import Combine

protocol CitiesListProviding {
    func getExchangeRateForCurrentDate() -> AnyPublisher<DataResponse, Error>
}

struct CitiesListProvider: CitiesListProviding {
    let apiSession: APISessionProviding
    
    func getExchangeRateForCurrentDate() -> AnyPublisher<DataResponse, Error> {
        apiSession.execute(CitiesListEndpoint.citiesList)
            .catch { _ in
                Empty<DataResponse, Error>()
            }
            .eraseToAnyPublisher()
    }
}
