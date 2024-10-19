import SwiftUI
import Foundation

struct MoreView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var youTubeAPIService = YouTubeAPIService()
    
    var body: some View {
        VStack {
            if let city = locationManager.userCity, let state = locationManager.userState {
                Text("Latest Hurricane Videos in \(city), \(state)")
                    .font(.headline)
                    .padding()

                if youTubeAPIService.videos.isEmpty {
                    Text("Loading videos...")
                        .padding()
                        .onAppear {
                            youTubeAPIService.searchVideos(for: city, state: state)
                        }
                } else {
                    ScrollView {
                        ForEach(youTubeAPIService.videos) { video in
                            VStack(alignment: .leading) {
                                Text(video.snippet.title)
                                    .font(.headline)
                                
                                Text("Published on: \(formattedDate(from: video.snippet.publishedAt))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                if let videoURL = URL(string: video.videoURL) {
                                    Link("Watch on YouTube", destination: videoURL)
                                        .foregroundColor(.blue)
                                } else {
                                    Text("Invalid video URL")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                    .padding()
                }
            } else {
                Text("Detecting your location...")
                    .padding()
                    .onAppear {
                        locationManager.startTracking()
                    }
            }
        }
        .padding()
    }
    
    // Function to format the published date
    private func formattedDate(from isoDate: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: isoDate) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: date)
        }
        return isoDate // Return the original string if formatting fails
    }
}
