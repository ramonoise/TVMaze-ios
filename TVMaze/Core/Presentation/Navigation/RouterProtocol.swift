import Foundation
import SwiftUI

@MainActor
protocol RouterProtocol: Observable, ObservableObject {
    associatedtype Route where Route: Hashable
    
    var path: NavigationPath { get set }
    
    func push(route: Route)
    func pop()
    func popToRoot()
}

@MainActor
extension RouterProtocol {
    func push(route: Route) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
