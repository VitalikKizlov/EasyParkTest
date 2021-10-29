//
//  CitiesListViewModel.swift
//  EasyParkTest
//
//  Created by Vitalii Kizlov on 29.10.2021.
//

import Foundation
import Combine
import CoreLocation

enum ViewModelState {
    case inActive
    case loading
    case finishedLoading
    case error(Error)
}

final class CityListViewModel {
    
    let session: APISessionProviding
    let citiesListProvider: CitiesListProviding
    
    private let locationService = LocationService()
    private var subscriptions = Set<AnyCancellable>()
    private var userLocation: CLLocation?
    
    @Published private(set) var cityViewModels: [CityViewModel] = []
    @Published private(set) var state: ViewModelState = .inActive
    
    // MARK: - Init
    
    init(apiSession: APISessionProviding = ApiSession()) {
        self.session = apiSession
        self.citiesListProvider = CitiesListProvider(apiSession: self.session)
    }
    
    func requestLocation() {
        let locationCompletionHandler: (Subscribers.Completion<LocationService.LocationError>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error):
                print("Failure: \(error.localizedDescription)")
                self?.state = .error(error)
                self?.getCities()
            case .finished:
                self?.getCities()
            }
        }
        
        let locationValueHandler: (CLLocation) -> Void = { [weak self] location in
            guard let self = self else { return }
            self.userLocation = location
        }
        
        locationService.requestWhenInUseAuthorization()
            .flatMap { _ in
                self.locationService.requestLocation()
            }
            .sink(receiveCompletion: locationCompletionHandler, receiveValue: locationValueHandler)
            .store(in: &subscriptions)
    }
    
    private func getCities() {
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
            let viewModels = data.cities.map { city -> CityViewModel in
                var model = CityViewModel(city: city)
                model.calculateDistanceToUser(self.userLocation)
                return model
            }
            self.cityViewModels = viewModels
        }
        
        citiesListProvider.getExchangeRateForCurrentDate()
            .print()
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &subscriptions)
    }
}
