import Foundation
//
public class GoogleMapsResources {
    // This empty struct just makes this a valid Swift module
    public static let resourceBundle = Bundle.module
}

extension Bundle {
    static var module: Bundle {
        return .init(for: GoogleMapsResources.self)
    }
}
