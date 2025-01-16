import SwiftUI

struct EpisodeView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 200)
                .foregroundColor(.gray)

            Text("Episode Name")
                .font(.title)
                .bold()

            Text("Episode #<number>")
                .font(.subheadline)

            Text("Season #<season>")
                .font(.subheadline)

            Text("Summary")
                .font(.body)

            Spacer()
        }
        .padding()
        .navigationTitle("Episode Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EpisodeView()
}
