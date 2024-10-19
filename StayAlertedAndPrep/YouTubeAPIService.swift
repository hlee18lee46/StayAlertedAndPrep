
import Foundation

class YouTubeAPIService: ObservableObject {
    @Published var videos: [YouTubeVideo] = []
    
    let apiKey = "AIzaSyBMjCQSqjthzHMDx7K-c_BSAKxrew1xCZE" // Replace with your actual API key

    // Function to search YouTube videos based on a location (city and state)
    func searchVideos(for city: String, state: String) {
        let query = "\(city) \(state) hurricane"
        let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(query)&type=video&key=\(apiKey)"
        
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                // Print the raw JSON for debugging purposes
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON Response: \(jsonString)")
                }

                do {
                    print("debug data: \(data)")
                    print("debug YouTubeSearchResponse.self: \(YouTubeSearchResponse.self)")

                    let videoResponse = try JSONDecoder().decode(YouTubeSearchResponse.self, from: data)
                    print("debug11")
                    DispatchQueue.main.async {
                        self.videos = videoResponse.items
                    }
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.dataCorrupted(context) {
                    print("Data corrupted:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("Error decoding YouTube video data: \(error)")
                }
            } else if let error = error {
                print("Error fetching YouTube videos: \(error)")
            }
        }.resume()
    }
}

struct YouTubeSearchResponse: Codable {
    let items: [YouTubeVideo]
}

struct YouTubeVideo: Codable, Identifiable {
    let idg: VideoID // The `id` object that contains `videoId`
    let snippet: Snippet

    // Use `videoId` for `Identifiable` conformance
    var videoId: String {
        return idg.videoId
    }

    // Use `videoId` as the `id` for `Identifiable`
    var id: String {
        return videoId
    }

    // Provide a full YouTube video URL
    var videoURL: String {
        return "https://www.youtube.com/watch?v=\(videoId)"
    }
}

struct VideoID: Codable {
    let videoId: String  // The actual video ID from the `id` object in JSON
}

struct Snippet: Codable {
    let title: String
    let description: String
    let publishedAt: String
    let thumbnails: Thumbnails
}

struct Thumbnails: Codable {
    let high: Thumbnail
    let medium: Thumbnail?
}

struct Thumbnail: Codable {
    let url: String
    let width: Int?
    let height: Int?
}
