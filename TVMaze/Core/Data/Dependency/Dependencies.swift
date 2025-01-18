import Foundation
import SwiftUI

protocol TVShowDependencies {
    var tvShowDataSource: TVShowDataSourceProtocol { get }
}

final class TVShowDependenciesResolver: TVShowDependencies {
    var tvShowDataSource: TVShowDataSourceProtocol {
        let httpClient = HttpClient(urlSession: URLSession.shared, decoder: JSONDecoder())
        return TVShowDataSource(httpClient: httpClient)
    }
}

struct TVShowDependenciesKey: EnvironmentKey {
    static let defaultValue: TVShowDependencies = TVShowDependenciesResolver()
}

extension EnvironmentValues {
    var tvShowDependencies: TVShowDependencies {
        get { self[TVShowDependenciesKey.self] }
        set { self[TVShowDependenciesKey.self] = newValue}
    }
}
