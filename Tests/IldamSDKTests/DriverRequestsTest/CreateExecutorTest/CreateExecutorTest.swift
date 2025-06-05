//
//  CreateExecutorTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 03/05/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class CreateExecutorTest: XCTestCase {
    func test_fetchColor() async {
        UserSettings.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiMjQ3MTUzZTI1NjNkZDZiMmI2MWEyNTQ0YzdmZDBjYjkyN2YxYWEwYWM4OWZjNjZlZGIxZWY5MDJlZTZkMjljMDM1MWEyMTc1YjhjZjUxMzMiLCJpYXQiOjE3NDkxMDg1ODYuOTUyNjI1LCJuYmYiOjE3NDkxMDg1ODYuOTUyNjI3LCJleHAiOjE3ODA2NDQ1ODYuOTQ4NzIzLCJzdWIiOiIxMjQ3OSIsInNjb3BlcyI6WyJleGVjdXRvciJdfQ.kHEuqSY90Uez6QSOktVHZhDgbTPx4myMKMg_qdEE7bBV0McsOnjKV_9i-xGRFqj18uOPUQnRXJxKEHVfFz7GX1Yvm-DnNallz8xuFQQLUoYvrJbLHMdZW9mWz8JXNqriPb1oZ3tRj36aHe_Mr3vhtoMEi45yqEWeDp-P-6UiiMalnU4IBVYUcip_zfl4cdBenwGfE1wnXeGhc-z4zxNLKLknVghrxqILdFOF4P3GCHS19UZHOgE2eeb8LK5ocbJ08hr_TMBo_pA899yOM_mvos-44D7RKIlXBhzEL--b4RXTqREv_1yM4ujFhMepM9nBavQtV4vfkcvwffKML7p1yPi6eelaIiviup4dKIs3E-k7R7QHetnMMwXhVtVlwggfrHrTE7hXCML4zsofv3wqyA3lN1C_zrmkJRJSvvArMQ58C_7OvRw52eK5Vx9ws2PfoF1WZ-rGoEh8oVWj_AuBms7Dew1SK-J6ZDfdN0pYkGBx3jXGLTd8_BNXu_Da8DonmrDRjVhyCp5CuojKqDGGlRl17D6ihOCWZMZp8AFV-r8HtaiwLnUsmdHYbd0jMUaBOpc4EbKuK-xsTWXV0cQoE6cforyqGI_5WVO1KUfccHlm3rPCwp7NvUN4VALpqvRB8bsZX9cKP2PlWt0dXbSOzdYxDeIpYyfYEcDBfse4G6g"

        let gateway = CreateExecutorGateway()
        let result = try? await gateway.register(body: DNetDriverRegisterBody(
            phone: "+99899992355",
            givenNames: "Hikmatulloh",
            surName: "Hakimov",
            addressId: 5,
            brandId: 2,
            modelId: 3,
            markId: 4,
            colorId: 1,
            driverLicenseCategories: [],
            stateNumber: "60A101s11",
            carMakeDate: 2030,
            driverLicense: "adasss5sssssssssssssss",
            driverLicenseDate: "2010-05-03",
            driverLicenseDateExpiry: "2010-05-03",
            driverGraduate: "1058451",
            birthday: "2024-01-07T11:40:15.819Z",
            gender: "MALE",
            fatherName: "dsf"
        ))
        print("Register: ", result?.executor?.givenNames)
        XCTAssertNotNil(result)
        
    }
}
