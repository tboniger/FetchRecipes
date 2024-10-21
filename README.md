## FetchRecipes App

### Steps to Run the App

**Clone the Repository in Terminal or via XCode**

   ```bash
   git clone https://github.com/yourusername/FetchRecipes.git
   ```

**Open the Project in Xcode**

   ```bash
   cd FetchRecipes
   open FetchRecipes.xcodeproj
   ```
   
**Build and Run**

   - Select a simulator running iOS 16 or later, or connect an iOS device running iOS 16+.
   - Build and run the project using `Command + R` in Xcode.

**Run Unit Tests**

   - To execute unit tests, select the `FetchRecipes` scheme.
   - Press `Command + U` to run all unit tests.

---

## Focus Areas

### **Concurrency and Async/Await Integration**
I prioritized implementing Swift Concurrency using `async`/`await` to handle asynchronous network calls efficiently. This modern approach leads to cleaner, more readable code and improves performance by avoiding callback hell associated with completion handlers.

### **Unit Testing**
I focused on writing unit tests for both the networking layer (`NetworkClient`) and the view model (`RecipesViewModel`). By mocking dependencies and using protocols for abstraction, and each component behaves correctly under various scenarios, such as successful responses, error handling, and decoding failures.

### **Error Handling and User Experience**
I implemented error handling to gracefully manage different error scenarios, such as network failures, decoding errors, and empty data responses. The app provides clear feedback to the user, displaying appropriate messages and allowing them to retry failed operations.

---

## Time Spent

I spent approximately **4.0 hours** on this project. Here's how I allocated my time:

- **Project Setup and Architecture Planning**: 0.5 hour  
  - Setting up the Xcode project and organizing the file structure.  
  - Planning the architecture using MVVM pattern.

- **Implementing Networking Layer**: 1 hour  
  - Developing `NetworkClient` and related network request structures.  
  - Handling network calls using `async`/`await`.

- **Building the UI with SwiftUI**: 1 hour  
  - Designing `RecipeListView`, `RecipeRowView`, and `RecipeDetailView`.  
  - Implementing image loading and caching.

- **Writing Unit Tests**: 1 hours  
  - Creating unit tests for `NetworkClient` and `RecipesViewModel`.  
  - Mocking network responses and handling asynchronous testing.

- **Debugging and Refinement**: 0.5 hours  
  - Fixing issues related to asynchronous operations in tests.  
  - Polishing UI elements and ensuring a smooth user experience.

---

## Trade-offs and Decisions

### **Async/Await vs. Completion Handlers**
I chose to use `async`/`await` for asynchronous operations, which required setting the minimum deployment target to iOS 16. This decision limits the app's compatibility to devices running iOS 16 or later but allows for cleaner and more readable asynchronous code.

### **Simplified UI**
Due to time constraints, I focused on functionality over advanced UI/UX enhancements. The app has a simple, clean interface that meets the assignment requirements but doesn't include additional animations or custom styling.

### **Image Caching**
I implemented simple image caching using `NSCache` to reduce network usage when loading images. If I had more time, I'd might consider using a more robust third-party library for caching or went with image caching images via CoreData.

---

## Weakest Part of the Project

The weakest part of the project is the **UI/UX design**. While the app meets the functional requirements, the interface could be more polished with better visual design, custom components, and animations to enhance the user experience. Given more time, I would focus on improving the UI to make the app more engaging and visually appealing.

If I had more time, I would have introduced a more robust caching mechanism, and would have liked to add filtering based on cuisine type.

---

## External Code and Dependencies

I did not use any external libraries or dependencies. All functionality, including image caching and networking, was implemented using native Swift and SwiftUI frameworks.

---

## Additional Information

- **Error Handling for Test Endpoints**  
  The app correctly handles the provided test endpoints for malformed and empty data. When encountering malformed data, it displays an error message and allows the user to retry fetching the recipes. For empty data, it shows an empty state message indicating that no recipes are available.

- **Swift Concurrency and @MainActor**  
  Managing `@MainActor` isolation in the view model and tests required careful attention. I ensured that all interactions with `@MainActor`-isolated properties were done on the main actor to prevent threading issues.

- **Testing Approach**  
  I focused on writing unit tests that cover both successful and failure scenarios, including:  
  - Successful data fetching and parsing.  
  - Handling HTTP error responses.  
  - Managing decoding errors with malformed data.  
  - Simulating network request failures.

---
