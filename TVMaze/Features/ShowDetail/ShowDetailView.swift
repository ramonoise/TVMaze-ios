import CachedAsyncImage
import SwiftUI

struct ShowDetailView: View {
    @EnvironmentObject private var router: AppRouter
    @StateObject private var viewModel: ShowDetailViewModel
    
    init(viewModel: ShowDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @ViewBuilder
    func loadedView(showDetail: TVShowDetail) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                CachedImageWithFallback(imageUrl: showDetail.image.originalURL,
                                        fallbackUrl: showDetail.image.mediumURL)
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 300)
                
                Text(showDetail.name)
                    .font(.title)
                    .bold()
                
                Text("Genres: \(showDetail.genres.joined(separator: ", "))")
                    .font(.subheadline)
                
                Text("Airs at \(showDetail.schedule.time) on \(showDetail.schedule.days.joined(separator: ", "))")
                    .font(.subheadline)
                
                RichTextView(html: showDetail.summary)
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
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
                case .loading:
                    ProgressView()
                case .loaded(let showDetail):
                    loadedView(showDetail: showDetail)
                case .failed(let errorMessage):
                    Text(errorMessage)
            }
        }
        .navigationTitle("Show Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
    }
}
