import SwiftUI

struct SearchView: View {
    @State private var searchText = ""

    var body: some View {
        VStack {
            TextField("Search TV series, shows, etc", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(0..<12) { _ in
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 100, height: 150)
                                .foregroundColor(.gray)
                            Text("Show's name")
                                .font(.caption)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SearchView()
}
