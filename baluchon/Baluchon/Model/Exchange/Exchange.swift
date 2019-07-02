//
//  Exchange.swift
//  BaluchonTests
//
//  Created by Jordan MOREAU on 14/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

// Datas we want to decode from JSON (here all rates from EURO)

struct Exchange: Decodable {
    let rates: [String: Double]
}

