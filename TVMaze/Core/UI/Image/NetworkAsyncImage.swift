import SwiftUI

struct NetworkAsyncImage: View {
    var placeholderImage = Image(systemName: "photo")
    var url: URL?
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
                case .success(let image):
                    image
                default:
                    placeholderImage
            }
        }
    }
}


#Preview {
    NetworkAsyncImage()
}
