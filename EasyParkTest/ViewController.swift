//
//  ViewController.swift
//  EasyParkTest
//
//  Created by Vitalii Kizlov on 29.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let citiesViewModel = CitiesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        citiesViewModel.getCities()
    }


}

