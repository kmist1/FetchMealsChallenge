# FetchRecipesChallenge

### Summary: 
This project is a coding challenge that focuses on fetching and displaying list of recipes using Swift, SwiftUI, Async/Await and Combine. The application features a network layer, a view model, and a simple user interface for displaying list of recipes sorted by cuisine.

![Simulator Screen Recording - iPhone 16 Pro - 2025-01-28 at 09 34 11](https://github.com/user-attachments/assets/5f898807-c315-4c85-8f58-d8a9f37f4b13)


### Focus Areas: 

## Network Layer
NetworkManager: A singleton class responsible for handling network requests and data fetching operations. This class utilizes async/await syntax for asynchronous network calls and error handling.

## View Model
RecipePageViewModel: Responsible for managing the business logic related to the Recipe list. It uses NetworkManager to fetch a list of desserts and updates the UI accordingly.

## Models
Recipe: Represents a recipe with properties such as id, name, category, photoUrl, videoUrl etc.

## Usage
The main view of the application displays a list of recipes. sort recipe by cuisine or name.

### Time Spent:
Research and System Design - 1 to 2 Hrs
Network Layer Implementation - 1 Hr
ViewModels and Models implementation and integration - 2 Hr
Unit Testing using TDD approach - 1 Hr
UI Development - 1 Hr

### Trade-offs and Decisions: 

### Weakest Part of the Project: 
UI Testing - I would add UI testing as well given time.

### Additional Information:
