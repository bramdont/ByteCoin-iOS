//
//  ExchangeRate.swift
//  ByteCoin
//
//  Created by Bramdont José García Aponte on 5/3/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct ExchangeRate: Decodable {
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
