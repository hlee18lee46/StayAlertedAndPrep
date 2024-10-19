import SwiftUI

struct LandingPageView: View {
    @Binding var showLandingPage: Bool // Binding to hide the landing page once user clicks "Get Started"
    
    var body: some View {
        VStack {
            Spacer()
            
            // Display the logo (make sure it's added to your Assets with the correct name)
            Image("Image") // Replace "Image" with the actual name of your image file
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
                .padding(.bottom, 20)
            
            Text("Your personal emergency preparedness app. Stay ahead, stay safe!")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal, 40)
            
            Spacer()
            
            // 'Get Started' Button to hide landing page and show the app
            Button(action: {
                showLandingPage = false
            }) {
                Text("Get Started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            }
            .padding(.bottom, 50)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}
