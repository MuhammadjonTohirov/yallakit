//
//  ActiveOrders+Mock.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 31/12/24.
//

import Foundation

extension NetResActiveOrders {
    static var mock: NetResActiveOrders {
        .init(list: [NetResOrderDetails.mock])
    }
}

extension NetResOrderDetails {
    static var mock: NetResOrderDetails {
        .init(
            id: 1216985,
            dateTime: 1735663998,
            service: "road",
            status: "new",
            executor: nil,
            taxi: .mock,
            comment: ""
        )
    }
    
    static func mockWith(status: String, orderDate: Date, detail: NetResOrderTaxiDetails?, taxi: NetResTaxiOrderExecutor?) -> NetResOrderDetails {
        var _mock = self.mock
        _mock.status = status
        _mock.taxi = detail
        _mock.dateTime = orderDate.timeIntervalSince1970
        _mock.executor = taxi
        return _mock
    }
}

extension NetResOrderTaxiDetails {
    static var mock: NetResOrderTaxiDetails {
        .init(
            tariff: "Test Uchun tariff",
            startPrice: 1000,
            distance: 1,
            clientTotalPrice: nil,
            totalPrice: 6000,
            fixedPrice: false,
            routes: [
                .init(
                    index: 1,
                    fullAddress: "From address",
                    coords: .init(lat: 40.3838485874778, lng: 71.78310088813305)
                ),
                .init(
                    index: 2,
                    fullAddress: "To address",
                    coords: .init(lat: 40.387981896981, lng: 71.798038780689)
                )
            ],
            services: [],
            bonusUsed: false
        )
    }
    
    
}

extension NetResTaxiOrderExecutor {
    static var mock: NetResTaxiOrderExecutor {
        .init(
            id: 123,
            phone: "998941231212",
            givenNames: "Jamoliddin",
            surName: "Alisherov",
            fatherName: "Davron o'g'li",
            photo: "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?t=st=1735664311~exp=1735667911~hmac=d817fa76f882c43a6eef407ff12f323c72647f8e80613ba651100c19cc3ffdf8&w=996",
            rating: 4,
            coords: .init(lat: 40.38384858747762, lng: 71.78310088813305),
            driver: .init(
                id: 9283,
                color: .init(color: "0x000000", colorName: "Black"),
                stateNumber: "A123NN",
                mark: "40",
                model: "Matiz"
            )
        )
    }
    
    static func mockWith(coord: (lat: Double, lng: Double)) -> Self {
        var _mock = self.mock
        _mock.coords = .init(lat: coord.lat, lng: coord.lng)
        return _mock
    }
}
