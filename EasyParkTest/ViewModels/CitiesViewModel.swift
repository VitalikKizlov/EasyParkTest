//
//  CitiesListViewModel.swift
//  EasyParkTest
//
//  Created by Vitalii Kizlov on 29.10.2021.
//

import Foundation
import Combine

enum ViewModelState {
    case inActive
    case loading
    case finishedLoading
    case error(Error)
}

final class CitiesViewModel {
    
    let session: APISessionProviding
    let citiesListProvider: CitiesListProviding
    var citiesViewModels: [CityViewModel] = []
    
    private var subscriptions = Set<AnyCancellable>()
    @Published private(set) var state: ViewModelState = .inActive
    
    // MARK: - Init
    
    init(apiSession: APISessionProviding = ApiSession()) {
        self.session = apiSession
        self.citiesListProvider = CitiesListProvider(apiSession: self.session)
    }
    
    func getCities() {
        state = .loading
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error):
                print("Failure: \(error.localizedDescription)")
                self?.state = .error(error)
            case .finished:
                print("Finished")
                self?.state = .finishedLoading
            }
        }
        
        let valueHandler: (DataResponse) -> Void = { [weak self] data in
            guard let self = self else { return }
            let viewModels = data.cities.map({ CityViewModel(city: $0) })
            self.citiesViewModels = viewModels
        }
        
        citiesListProvider.getExchangeRateForCurrentDate()
            .print()
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &subscriptions)
    }
    
}
