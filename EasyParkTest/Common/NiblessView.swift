//
//  NiblessView.swift
//  EasyParkTest
//
//  Created by Vitalii Kizlov on 29.10.2021.
//

import UIKit

class NiblessView: UIView {
    
    public init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable, message: "Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
    
}
