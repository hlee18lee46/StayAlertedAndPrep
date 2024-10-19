import SwiftUI
import Foundation

struct YouTubeVideosView: View {
    @StateObject private var youTubeAPIService = YouTubeAPIService()
    let city: String
    let state: String
    
    var body: some View {
        VStack {
            Text("Latest Hurricane Videos in \(city), \(state)")
                .font(.title)
                .padding(.top)

            if youTubeAPIService.videos.isEmpty {
                Text("No videos found or loading...")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ScrollView {
                    LazyVStack(spacing: 20) {  // Use LazyVStack for performance and add spacing
                        ForEach(youTubeAPIService.videos) { video in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(video.snippet.title)
                                    .font(.headline)
                                
                                Text(video.snippet.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                Link("Watch on YouTube", destination: URL(string: video.videoURL)!)
                                    .foregroundColor(.blue)
                                
                                // Safely unwrap the optional Thumbnail
                                if let thumbnail = video.snippet.thumbnails.medium {
                                    if let thumbnailURL = URL(string: thumbnail.url) {
                                        AsyncImage(url: thumbnailURL) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 400)
                                                .cornerRadius(10)  // Rounded corners for thumbnails
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))  // Background for each video item
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .onAppear {
            youTubeAPIService.searchVideos(for: city, state: state)
        }
        .padding(.bottom)
    }
}
