//
//  MappView.swift
//  Walker's-Gate
//
//  Created by Wteen Alghamdy on 13/08/1447 AH.
//
//جسر الربط مع Mapbox. يظهر سهم اتجاه اللاعب (Puck) وتفاعله مع المسار الرياضي.

import Foundation
import UIKit
import MapboxMaps
import SwiftUI

struct MapViewRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}

final class ViewController: UIViewController {
    private var cancelables = Set<AnyCancelable>()
    private var mapView: MapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        MapboxOptions.accessToken = "pk.eyJ1IjoidG9udG9uOTg3IiwiYSI6ImNta3h6NmhhNjAxd3EzY3IwMnBpYjJzN2wifQ.WijVe78U3fJpIDS2mU_rmg"
        
        let centerCoordinate = CLLocationCoordinate2D(latitude: 24.861390, longitude: 46.725816)
        
        let myMapInitOptions = MapInitOptions(
            cameraOptions: CameraOptions(center: centerCoordinate, zoom: 16)
        )

        mapView = MapView(frame: view.bounds, mapInitOptions: myMapInitOptions)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        var puckConfiguration = Puck2DConfiguration.makeDefault()
        puckConfiguration.pulsing = .default
        mapView.location.options.puckType = .puck2D(puckConfiguration)

        mapView.location.onLocationChange.observeNext { [weak mapView] newLocation in
            guard let mapView, let location = newLocation.last else { return }
            mapView.mapboxMap.setCamera(to: .init(center: location.coordinate, zoom: 18))
        }.store(in: &cancelables)
    }
}
