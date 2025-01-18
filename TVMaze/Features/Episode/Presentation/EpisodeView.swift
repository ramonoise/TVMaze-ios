import SwiftUI

struct EpisodeView: View {
    var episode: TVShowEpisode
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                CachedImageWithFallback(imageUrl: episode.image?.originalURL,
                                        fallbackUrl: episode.image?.mediumURL)
                .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                .foregroundColor(.gray)
                .cornerRadius(10)
                
                Text(episode.name)
                    .font(.title)
                    .bold()
                
                Text("Season \(episode.season), Episode \(episode.number)")
                    .font(.title3)
                
                RichTextView(html: episode.summary)
                    .font(.body)
                
                Spacer()
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EpisodeView(episode: .init(id: 1,
                               name: "Mocked Episode",
                               number: 10,
                               season: 1,
                               summary: "<b>Lorem</b> ipsum",
                               image: .init(mediumURL: "https://dummyimage.com/150",
                                            originalURL: "https://dummyimage.com/150")))
}
