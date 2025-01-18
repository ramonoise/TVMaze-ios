import Foundation

enum EpisodeFactory {
    static func build(episode: TVShowEpisode) -> EpisodeView {
        EpisodeView(episode: episode)
    }
}
