//
//  APISessionProviding.swift
//  EasyParkTest
//
//  Created by Vitalii Kizlov on 29.10.2021.
//

import Foundation
import Combine

protocol APISessionProviding {
  func execute<T: Codable>(_ requestProvider: RequestProviding) -> AnyPublisher<T, Error>
}
