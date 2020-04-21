//
//  Service.swift
//  Bitcoin price
//
//  Created by George on 21/04/2020.
//  Copyright © 2020 George. All rights reserved.
//

import Foundation

protocol ServiceDelegate {
    func didFailWithError(error : Error)
    func didUpdatePrice(_ service :Service , bitcoin : Bitcoin)
}

class Service{
    let bitcoinAPI = "https://api.coindesk.com/v1/bpi/currentprice/"
    var currency = ""
    
    var delegate : ServiceDelegate?
    
    func getPrice(currency : String) {
        let urlString = bitcoinAPI + currency + ".json"
        performRequest(urlString)
        self.currency = currency
    }
    func performRequest(_ urlString : String) {
        guard let url = URL(string: urlString) else{
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response,error) in
            if error != nil{
                self.delegate?.didFailWithError(error: error!)
                return
            }
            if let safeData = data{
                if let bitcoin = self.parseJSON(safeData){
                    self.delegate?.didUpdatePrice(self,bitcoin: bitcoin)
                }
            }
            
        }
        task.resume()
    }
    func parseJSON(_ bitcoinData : Data) -> Bitcoin? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(BitcoinData.self, from: bitcoinData)
            var price = 0.0
            var name = ""
            switch currency {
                case "EUR":
                    price = decodedData.bpi.EUR?.rate_float ?? 0
                    name = "EUR"
                case "USD":
                    price = decodedData.bpi.USD?.rate_float ?? 0
                    name = "USD"
                case "RON":
                    price = decodedData.bpi.RON?.rate_float ?? 0
                    name = "RON"
                case "GBP":
                    price = decodedData.bpi.GBP?.rate_float ?? 0
                    name = "GBP"
                default:
                    price = 0.0
            }
            let bitcoin = Bitcoin(currency: name,value: price)
            return bitcoin
        }
        catch{
            
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
