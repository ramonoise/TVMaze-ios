import SwiftUI

struct TVShowCardView: View {
    var tvShow: TVShow
    
    var body: some View {
        AsyncImageWithFallback(imageUrl: tvShow.image.mediumURL)
            .bordered()
            .textOverlay(text: tvShow.name)
    }
}

// MARK: Extensions
private extension View {
    func bordered() -> some View {
        self.frame(width: 120, height: 180)
            .cornerRadius(10)
    }
    
    func textOverlay(text: String) -> some View {
        self.overlay(
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .font(.caption)
                .padding(5)
                .background(Color.black.opacity(0.6))
                .cornerRadius(5),
            alignment: .bottom
        )
    }
}

// MARK: Preview
#Preview {
    TVShowCardView(
        tvShow: .init(id: 1, 
                      name: "TV show",
                      image: .dummy()))
}
