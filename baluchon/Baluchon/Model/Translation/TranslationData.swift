//
//  Translation.swift
//  Baluchon
//
//  Created by Jordan MOREAU on 15/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

struct TranslationData: Decodable {
    let data: TranslationDataClass
}

// MARK: - DataClass
struct TranslationDataClass: Decodable {
    let translations: [Translation]
}

// MARK: - Language
struct Translation: Decodable {
    let translatedText: String
}
