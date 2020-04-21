//
//  Bitcoin.swift
//  Bitcoin price
//
//  Created by George on 21/04/2020.
//  Copyright © 2020 George. All rights reserved.
//

import Foundation

class Bitcoin {
    let currency : String
    let value : Double
    
    init(currency : String, value : Double) {
        self.currency = currency
        self.value = value
    }
}
