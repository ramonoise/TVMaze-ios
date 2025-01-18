import SwiftUI
import CachedAsyncImage

struct CachedImageWithFallback: View {
    var imageUrl: String?
    var fallbackUrl: String?
    
    var body: some View {
        CachedAsyncImage(url: URL(string: imageUrl ?? "")) { imageResponse in
            switch imageResponse {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                default:
                    CachedAsyncImage(url: URL(string: fallbackUrl ?? "")) { fallbackResponse in
                        switch fallbackResponse {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                            default:
                                Image(systemName: "photo")
                        }
                    }
            }
        }
    }
}

#Preview {
    let dummyImageURL: String = "https://dummyimage.com/150"
    return CachedImageWithFallback(imageUrl: dummyImageURL,
                                   fallbackUrl: dummyImageURL)
}
