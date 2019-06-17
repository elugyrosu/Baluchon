//
//  TranslationSymbols.swift
//  Baluchon
//
//  Created by Jordan MOREAU on 15/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

struct TranslationSymbols: Decodable {
    let data: DataClass
}
    
    // MARK: - DataClass
struct DataClass: Decodable {
    let languages: [Language]
}
    
    // MARK: - Language
struct Language: Decodable {
    let language, name: String
}
