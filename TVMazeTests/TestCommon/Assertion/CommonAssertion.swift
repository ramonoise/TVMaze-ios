import Combine
import SwiftUI
import XCTest

//protocol ViewModelWithState: ObservableObject {
//    var state: Binding<any Equatable> { get set }
//}

protocol ViewModelWithState: ObservableObject {
    associatedtype State: Equatable
    var state: State { get set }
    var statePublisher: Published<State>.Publisher { get }
}

extension XCTestCase {
    func observeState<T: Equatable, V: ViewModelWithState>(
        viewModel: V,
        cancellables: inout Set<AnyCancellable>,
        expectedState: T,
        action: @escaping () -> Void
    ) where V.State == T {
        
        let expectation = XCTestExpectation(description: "State should be \(expectedState)")
        
        // Observe the statePublisher
        viewModel.statePublisher
            .dropFirst()  // Skip the initial value
            .sink { state in
                print("Current state: \(state)")
                if state == expectedState {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        action()
        
        wait(for: [expectation], timeout: 1.0)
    }
}
