//
//  PointsStorage.swift
//  YaMapTestVictory
//
//  Created by MEV on 26.05.24.
//

import Foundation
import YandexMapsMobile

enum PointConst {
    static let victoryPoint = YMKPoint(latitude: 56.833742, longitude: 60.635716)
    static let victoryPosition = YMKCameraPosition(target: victoryPoint, zoom: 13.0, azimuth: .zero, tilt: .zero)
}
