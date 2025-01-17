import SwiftUI

struct ShowView: View {
    @EnvironmentObject private var router: AppRouter
    var tvShow: TVShow
    
    var genres: String {
        tvShow.genres.joined(separator: ", ")
    }
    
    var scheduleDays: String {
        tvShow.schedule.days.joined(separator: ", ")
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                NetworkAsyncImage(url: URL(string: tvShow.image.originalURL))
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 300)

                Text(tvShow.name)
                    .font(.title)
                    .bold()

                Text("Genres: \(genres)")
                    .font(.subheadline)

                Text("Airs at \(tvShow.schedule.time) on \(scheduleDays)")
                    .font(.subheadline)

                Text("Summary")
                    .font(.body)

                Text("Episodes")
                    .font(.title2)
                    .bold()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<10) { episode in
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 100, height: 150)
                                    .foregroundColor(.gray)
                                Text("Show's name")
                                    .font(.caption)
                            }.onTapGesture {
                                router.push(route: .episode(id: String(episode)))
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
    ShowView(tvShow: .init(id: 1,
                           name: "The Amazing Show",
                           image: .init(mediumURL: "",
                                        originalURL: ""),
                           genres: ["Drama", "Comedy", "Action"],
                           schedule: .init(time: "21:00",
                                           days: ["Sunday", "Saturday"])))
}
