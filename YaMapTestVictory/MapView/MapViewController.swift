//
//  MapViewController.swift
//  YaMapTestVictory
//
//  Created by MEV on 26.05.24.
//

import UIKit
import YandexMapsMobile
import MapKit

final class MapViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var locManager = CLLocationManager()

    private var mapView: YMKMapView!
    private var map: YMKMap!

    private lazy var routingViewModel = RoutingViewModel(controller: self)
    private lazy var mapInputListener: YMKMapInputListener = MapInputListener(routingViewModel: routingViewModel)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setupLocManager()
    }

    // MARK: - Private methods
    
    private func setupMapView() {
        mapView = YMKMapView(frame: view.frame)
        view.addSubview(mapView)
        map = mapView.mapWindow.map

        map.addInputListener(with: mapInputListener)

        routingViewModel.placemarksCollection = map.mapObjects.add()
        routingViewModel.routesCollection = map.mapObjects.add()
        
        move()
    }

    private func move(to cameraPosition: YMKCameraPosition = PointConst.victoryPosition) {
        map.move(with: cameraPosition, animation: YMKAnimation(type: .smooth, duration: 1.0))
    }
    
    private func setupLocManager() {
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        addRoutePoints(authorizationStatus: locManager.authorizationStatus)
    }
    
    private func addRoutePoints(authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            if let location = locManager.location {
                routingViewModel.addRoutePoint(YMKPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                routingViewModel.addRoutePoint(PointConst.victoryPoint)
            }
            
        default:
            AlertPresenter.present(from: self, with: "Authorization status", message: "The application needs to access your location.")
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let authStatus = manager.authorizationStatus
        addRoutePoints(authorizationStatus: authStatus)
    }
}
