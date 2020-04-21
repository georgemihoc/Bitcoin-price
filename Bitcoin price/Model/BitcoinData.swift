//
//  Bitcoin.swift
//  Bitcoin price
//
//  Created by George on 21/04/2020.
//  Copyright © 2020 George. All rights reserved.
//

import Foundation

class BitcoinData : Codable{
    let bpi : Bpi
    let disclaimer : String
    
    init(bpi : Bpi, disclaimer : String) {
        self.bpi = bpi
        self.disclaimer = disclaimer
    }
}
class Bpi: Codable {
//    let usd : EUR
    let EUR : EUR?
    let USD : USD?
    let RON : RON?
    let GBP : GBP?
}
class EUR : Codable{
    let rate_float: Double
}
class USD : Codable{
    let rate_float: Double
}
class RON : Codable{
    let rate_float: Double
}
class GBP : Codable{
    let rate_float: Double
}
