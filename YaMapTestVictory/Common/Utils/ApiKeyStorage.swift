//
//  ApiKeyStorage.swift
//  YaMapTestVictory
//
//  Created by MEV on 26.05.24.
//

import Foundation
import YandexMapsMobile

enum ApiKeyStorage {
    static let mapkitApiKey = Bundle.main.object(forInfoDictionaryKey: "MAPKIT_API_KEY") as? String ?? ""
}
