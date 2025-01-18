import SwiftUI

struct TypedAnyView: View {
    private let content: AnyView
    private let contentViewType: Any.Type

    public init<V: View>(_ sview: V) {
        self.content = AnyView(sview)
        self.contentViewType = V.self
    }

    func viewType() -> Any.Type {
        return self.contentViewType
    }

    var body: some View {
        content
    }
}
