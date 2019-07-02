//
//  Translation.swift
//  Baluchon
//
//  Created by Jordan MOREAU on 15/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

// Datas we want to decode from JSON (here the translated text, we have to respect JSON Structure

// MARK: - TranslationData
struct TranslationData: Decodable {
    let data: TranslationDataClass
}

// MARK: - TranslationDataClass
struct TranslationDataClass: Decodable {
    let translations: [Translation]
}

// MARK: - Language
struct Translation: Decodable {
    let translatedText: String
}
