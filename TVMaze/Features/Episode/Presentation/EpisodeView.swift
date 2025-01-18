import SwiftUI

enum EpisodeViewIdentifier: String, RawRepresentable {
    case name = "Episode_Title_Name"
    case seasonEpisodeNumbers = "Episode_SeasonEpisodeNumbers"
    case summary = "Episode_Scroll_Summary"
    
}

struct EpisodeView: View {
    var episode: TVShowEpisode
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImageWithFallback(imageUrl: episode.image?.originalURL,
                                       fallbackUrl: episode.image?.mediumURL)
                .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                .foregroundColor(.gray)
                .cornerRadius(10)
                
                Text(episode.name)
                    .font(.title)
                    .bold()
                    .accessibilityIdentifier(
                        EpisodeViewIdentifier.name.rawValue
                    )
                
                Text("Season \(episode.season), Episode \(episode.number)")
                    .font(.title3)
                    .accessibilityIdentifier(
                        EpisodeViewIdentifier.seasonEpisodeNumbers.rawValue
                    )
                
                RichTextView(html: episode.summary)
                    .font(.body)
                    .accessibilityIdentifier(
                        EpisodeViewIdentifier.summary.rawValue
                    )
                
                Spacer()
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EpisodeView(
        episode: .init(id: 1,
                       name: "Mocked Episode",
                       number: 10,
                       season: 1,
                       summary: "<b>Lorem</b> ipsum",
                       image: .dummy()))
}
