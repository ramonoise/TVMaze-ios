import SwiftUI

struct ShowView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 200)
                    .foregroundColor(.gray)

                Text("Show Name")
                    .font(.title)
                    .bold()

                Text("Genres: Genre1, Genre2")
                    .font(.subheadline)

                Text("Air date: <airdate>")
                    .font(.subheadline)

                Text("Summary")
                    .font(.body)

                Text("Episodes")
                    .font(.title2)
                    .bold()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<10) { _ in
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 100, height: 150)
                                    .foregroundColor(.gray)
                                Text("Show's name")
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Show Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ShowView()
}
