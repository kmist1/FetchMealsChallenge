# FetchRecipesChallenge

## Summary: 
This project is a coding challenge that focuses on fetching and displaying a list of recipes using Swift, SwiftUI, Async/Await, and Combine. The application features a network layer, a view model, and a simple user interface for displaying a list of recipes sorted by cuisine.

![Simulator Screen Recording - iPhone 16 Pro - 2025-01-28 at 09 53 44](https://github.com/user-attachments/assets/0586df32-e64c-434a-873d-dbe6ff739564)

## Focus Areas

### Network Layer

NetworkManager

	•	A singleton responsible for handling network requests and data fetching.
	•	Utilizes async/await for seamless asynchronous operations.
	•	Implements error handling to manage network failures, malformed data, and empty responses.
	•	Avoids third-party dependencies by relying solely on URLSession.
	•	Efficient Network Usage: Caches downloaded images to minimize redundant API calls and optimize performance.

### ViewModel

RecipesPageViewModel

	•	Manages business logic related to the Recipe List.
	•	Fetches data from NetworkManager and updates the UI state (success, failure, loading).
	•	Implements sorting functionality (by Cuisine or Name).
	•	Supports manual refresh and pull-to-refresh for real-time updates.
	•	Uses Combine and @Published properties to ensure reactive UI updates.

### Models

Recipe

	•	Represents a recipe with essential attributes:
	•	ID (uuid)
	•	Name
	•	Cuisine Category
	•	Image URLs (small & large)
	•	Source URL (original recipe)
	•	YouTube Video URL
	•	Implements Decodable to parse API responses efficiently.
	•	Ensures data validation by discarding malformed or incomplete JSON objects.

### User Interface

RecipesPageView

	•	Displays a scrollable list of recipes.
	•	Provides sorting controls (Picker to sort by Cuisine or Name).
	•	Implements pull-to-refresh using .refreshable for seamless updates.
	•	Gracefully handles empty states and error messages.
	•	Uses LazyVStack for memory-efficient rendering of long lists.

 ### Tests

 * Unit test for RecipePageViewModel 
 * App coverage > 85%

<img width="1728" alt="Screenshot 2025-01-28 at 10 48 44 AM" src="https://github.com/user-attachments/assets/e5ebff07-1733-48e4-9e9f-83b91e64c398" />



## Time Spent:
* Research and System Design - 1 to 2 Hrs
* Network Layer Implementation - 1 Hr
* ViewModels and Models implementation and integration - 2 Hr
* Unit Testing using TDD approach - 1 Hr
* UI Development - 1 Hr
* Adding AppIcon and Setting Launch Screen - 15min

### Trade-offs and Decisions: 

	•	No External Libraries: Chose to implement caching and networking manually to adhere to the requirement.
	•	Simplified UI: Kept the UI minimal with a focus on performance and functionality.
	•	Basic Sorting: Sorting is implemented locally rather than using API-side sorting for simplicity.
	•	Image Caching: Implemented custom caching instead of relying on URLSession caching to optimize network usage.
 
### Weakest Part of the Project: 
UI Testing 

	•	Given more time, I would add UI tests to ensure the user experience remains consistent across different states.
	•	Would implement integration tests to verify how the ViewModel interacts with the network layer.

### Additional Information:

	•	The project follows MVVM architecture for better separation of concerns.
	•	Implemented unit tests covering network requests, sorting, and error handling.
	•	Handled edge cases such as empty responses, network failures, and malformed JSON.
	•	The app is designed to be scalable, allowing easy expansion (e.g., adding a detail view).
