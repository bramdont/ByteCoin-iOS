//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didFailWithError(_ error: Error)
    func didGetExchange(_ exchange: ExchangeRate)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "6BE8B61D-1EF7-47E0-A95A-ABFC7CD8D75A"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let finalURL = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        perfomeRequest(for: finalURL)
    }
    
    func perfomeRequest(for urlString: String) {
        let url = URL(string: urlString)
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            print(urlString)
            if error != nil {
                delegate?.didFailWithError(error!)
            }
            if let safeData = data {
                if let rate = parseJON(data: safeData){
                    delegate?.didGetExchange(rate)
                }
            }
        }
        
        task.resume()
    }
    
    func parseJON(data: Data) -> ExchangeRate?{
        
        let decoder = JSONDecoder()
        do{
            let decodedExchange = try decoder.decode(ExchangeRate.self, from: data)
            
            let time = decodedExchange.time
            let asset_base = decodedExchange.asset_id_base
            let asset_quote = decodedExchange.asset_id_quote
            let rate = decodedExchange.rate
            
            return ExchangeRate(time: time, asset_id_base: asset_base, asset_id_quote: asset_quote, rate: rate)
            
        }catch {
            delegate?.didFailWithError(error)
            return nil
        }
        
    }
    
}
