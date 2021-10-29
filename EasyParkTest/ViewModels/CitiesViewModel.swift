//
//  CitiesListViewModel.swift
//  EasyParkTest
//
//  Created by Vitalii Kizlov on 29.10.2021.
//

import Foundation
import Combine

final class CitiesViewModel {
    
    let session: APISessionProviding
    let citiesListProvider: CitiesListProviding
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(apiSession: APISessionProviding = ApiSession()) {
        self.session = apiSession
        self.citiesListProvider = CitiesListProvider(apiSession: self.session)
    }
    
    func getCities() {
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error):
                print("Failure: \(error.localizedDescription)")
                //self?.state = .error(error)
            case .finished:
                print("Finished")
                //self?.state = .finishedLoading
            }
        }
        
        let valueHandler: (DataResponse) -> Void = { [weak self] data in
            guard let self = self else { return }
            print("Cities received ----", data.cities.count)
        }
        
        citiesListProvider.getExchangeRateForCurrentDate()
            .print()
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &subscriptions)
    }
    
}
