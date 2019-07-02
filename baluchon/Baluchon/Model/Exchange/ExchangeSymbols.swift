//
//  PickerViewSymbols.swift
//  BaluchonTests
//
//  Created by Jordan MOREAU on 14/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

// Datas we want from JSON, here all currencies availables from EURO

struct ExchangeSymbols: Decodable {
    let symbols: [String: String]
}
