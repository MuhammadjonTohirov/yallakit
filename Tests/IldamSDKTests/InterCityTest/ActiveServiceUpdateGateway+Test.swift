//
//  ActiveServiceUpdateGatewayTest.swift
//  YallaKit
//
//  Created by MuhammadAli Yo'lbarsbekov on 15/10/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class ActiveServiceUpdateGatewayTest: XCTestCase {
    func test_activeServiceUpdate() async {
        
        UserSettings.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiYTM2YjQ5OTdlNWZjNWZmYzkwZWUyZWNjMmI5YmUxZWI2NTFiNzBiNmIzZWY5ZWUzY2ZjNThkMzQ4NjEzYjkzMDBlODFjZGM0NzA5ODQ3YjgiLCJpYXQiOjE3NjA0MTg5MjMuMzE0NzAyLCJuYmYiOjE3NjA0MTg5MjMuMzE0NzA0LCJleHAiOjE3OTE5NTQ5MjMuMzEwNDQ0LCJzdWIiOiIxMjQ3OSIsInNjb3BlcyI6WyJleGVjdXRvciJdfQ.lt0QkXicAXRzapW3MRswsJ4oM4cY2BT8t-DeKowPn2_caxrovr_dllQ5u7wdP7OrIFyZ0qFt20qmoyZlWUvhtC65NFOivgdxvtmOvRNBNHTKn363oK3lwHe9C49wGv0N1Yz7WiPnLMO6W6vPfCjv66h8x1Jk7hLcndz9gRd5eZqpeIjUjG5b3hdATjkkon-M92_ogzyyiOj1WQiV-hhmFRiZBlua_XlrMuVAD8DK88sRWl2_fVouaZ05SVimYIJE2qcdPfCZiNPuqoailRW83edsjJ6r808HOS_clnFkfqBxn0BsXV255q4hQZtalQFjEL0qqJMQkGY3fb55Rhlf1Wzps-1HVuTPvji3tHTLT6do2EHmp0ac84xZitkmuStisX2muSZZ4CWcApP6saSUilFJCduP7WtYKZWKeYX2ka4TIpmV6FqP8UP424t8uePnH_dd0Rq7q-1qfMRzp0BDj5fbLe0PTHVnXc5YMS-nJzuB0k_IqnbrgiAsh6Ax9f97WUeRqQRuXiHr3fF1oNzxHqyfPsi1ccsQ8g5NpSP7Gvue9NRAVFURlyijYoP-9mhRs_79MjPD0hnSXAWTRDBFWzHX3U7K4CELlj1DaSYQJcg9veDTpqb8kJqFDauG7uuaTAWgwqtTbMrAyrJ8YSOJzYK7qpdP1oqKW9z982_o_dE"
        
        let gateway = ActiveServiceUpdateGateway()
        let result = try? await gateway.updateActiveService(id: "7")
        
        print("result: ", result)
        XCTAssertNotNil(result)
        
    }
}

