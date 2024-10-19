## Inspiration
The inspiration for StayAlertedAndPrep comes from the increasing frequency of natural disasters and the need for timely, localized information during emergencies. With hurricanes, floods, and other calamities affecting communities worldwide, there is a growing need for a mobile app that helps people stay informed and connected with nearby shelters, grocery stores, pharmacies, and critical alerts. We wanted to create an app that not only helps users prepare for disasters but also provides real-time, location-based updates to improve their safety and readiness.

## What it does
StayAlertedAndPrep is an all-in-one emergency preparedness app that provides users with vital resources during times of need. Some of its main features include:

	•	Flood Alerts: Real-time flood warnings to keep users updated on possible dangers in their area.
	•	Nearby Shelters: Displays a list of local hurricane shelters, complete with distance and maps to help users navigate in emergencies.
	•	Grocery Stores & Pharmacies: Provides locations of nearby grocery stores and pharmacies, crucial for restocking supplies before and after disasters.
	•	Nearby Disaster: A feed of disaster-related news from FEMA and other sources, ensuring users are always informed.
	•	Interactive Map: Users can view the locations of shelters, grocery stores, and pharmacies directly on an interactive map.

##How we built it

StayAlertedAndPrep was built using the following technologies:

	•	SwiftUI: For the user interface, providing a sleek and modern design.
	•	MapKit: Integrated to provide an interactive map for displaying nearby shelters, stores, and pharmacies.
	•	Google Places API: Used to search for nearby grocery stores and pharmacies based on the user’s current location.
	•	api.weather.gov: Used to search for flood alerts
	•	FEMA API: Used to pull disaster-related news and updates.
	•	CoreLocation: To track the user’s real-time location and provide accurate location-based search results.
	•	Swift: The primary programming language used to build the app for iOS.

##Challenges we ran into

One of the major challenges we faced was handling real-time location updates and ensuring that search results (shelters, grocery stores, pharmacies) were accurately displayed on the map. Additionally, working with multiple APIs like Google Places and FEMA required us to carefully manage network requests and handle errors gracefully to ensure a seamless user experience. Another challenge was designing the UI to make all essential information easily accessible during a crisis while maintaining simplicity.

##Accomplishments that we’re proud of

We are incredibly proud of the integration of multiple critical features, such as location-based searches for nearby resources and real-time disaster alerts, all in one app. The interactive map feature allows users to quickly navigate to shelters, grocery stores, and pharmacies. We’re also proud of the clean and intuitive UI design that makes the app easy to use, even under stressful circumstances.

##What we learned

Through the development of StayAlertedAndPrep, we learned the importance of reliable, real-time data in an emergency preparedness app. We deepened our understanding of API integration, particularly with location-based services like Google Places and FEMA. We also improved our skills in SwiftUI and MapKit, especially in handling dynamic content and maps in iOS applications. Working with real-time user location data was a significant learning experience that required careful consideration of privacy and accuracy.

##What’s next for StayAlertedAndPrep

Moving forward, we plan to add even more features to StayAlertedAndPrep, including:

	•	Custom Alerts: Allowing users to set specific disaster alerts and notifications tailored to their needs.
	•	Collaboration Features: Enabling users to share their real-time location with family and friends during a disaster.
	•	Offline Capabilities: Offering offline access to key resources like shelters and emergency contact numbers.
	•	Weather Updates: Integrating real-time weather forecasts and hurricane tracking maps for better preparedness.
	•	Community Support: Adding a feature where users can find or offer help to their neighbors during an emergency.
