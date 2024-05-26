//
//  MapInputListener.swift
//  YaMapTestVictory
//
//  Created by MEV on 26.05.24.
//

import YandexMapsMobile

final class MapInputListener: NSObject, YMKMapInputListener {
    
    init(routingViewModel: RoutingViewModel) {
        self.routingViewModel = routingViewModel
    }

    func onMapTap(with map: YMKMap, point: YMKPoint) {}

    func onMapLongTap(with map: YMKMap, point: YMKPoint) {
        routingViewModel.addRoutePoint(point)
    }

    private let routingViewModel: RoutingViewModel
}

