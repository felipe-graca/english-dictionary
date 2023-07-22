# English Dictionary App Overview

The English Dictionary app is a feature-rich mobile application designed to provide users with a comprehensive English word dictionary experience. With the integration of GPT-3, the app offers users word suggestions tailored to their preferences. The app allows users to search for words, save them to a favorite list, and view their search history. Additionally, it includes various functionalities such as text-to-speech, authentication with Google, and profile management.

## Screenshots
Figma design(UI/UX) created by me

![Alt Text](images/figma.png)

## Features

1. **Search Word**: Users can search for words using the app, gaining access to the meanings and definitions of various English words.

2. **Save Word to Favorite List**: The app allows users to save their favorite words to a designated list for easy access and reference.

3. **Save Word to History List**: Users can save searched words to their history list, enabling them to revisit previously searched words conveniently.

4. **Text-to-Speech Word**: With the integrated text-to-speech feature, users can listen to the correct pronunciation of words.

5. **Login with Google**: The app offers a seamless login process, allowing users to sign in with their Google accounts for a personalized experience.

6. **Logout**: Users can log out from their accounts if needed.

7. **View Favorite Words**: The app provides a dedicated section for users to view and manage their list of favorite words.

8. **View History Words**: Users can access their search history to see the words they have previously searched for.

9. **View Profile**: The app includes a profile page where users can view their latest viewed words and favorite words.

10. **View Total Number of New Words Viewed**: The app keeps track of the total number of new words a user has viewed.

11. **Edit Image Profile**: Users can customize their profile by editing their profile image.

12. **Search Word (In Progress)**: The development team is currently working on an enhanced search word feature to improve the user experience.

13. **Related Suggest Words with GPT-3 (In Progress)**: The app is integrating GPT-3 technology to provide users with related word suggestions based on their search history and preferences.

14. **Dark Mode (To Do)**: The team plans to implement a dark mode option to enhance user comfort during nighttime usage.

15. **Gamification (To Do)**: In the future, the app will incorporate gamification features to make the learning process more engaging and interactive.

16. **Search Word with Voice (To Do)**: The development team is working on implementing voice-based word search functionality to offer users a convenient alternative to typing.

17. **Search Word with Camera (To Do)**: The app is planned to include word search capabilities using the device's camera, allowing users to search for words in their surroundings.

18. **Suggest Words Based on Examples [Only Generated List Words] (To Do)**: The app will generate word suggestions based on examples provided by the user, aiding them in discovering related words.

19. **Unit Testing**: The app includes unit testing to ensure the stability and correctness of its features.

## Architecture

The app follows the principles of Clean Architecture and Clean Code to maintain a well-organized and scalable codebase. It comprises the following major components:

- **Core**: Contains core elements like errors, features, routes, use cases, services, and utilities.

- **Presenters**: Includes presenters responsible for handling UI interactions and widgets.

- **UI**: Manages the user interface components, shared components, and configurations. There is a plan to transfer this folder to the Design System in the future.

## Packages and Usage

The app utilizes various packages to implement its functionalities:

- Dependency Injection: `get_it` for dependency injection.

- Equatability and State Management: `equatable` for equality comparison and `flutter_bloc` for state management.

- Rest Service: `dio` for HTTP requests and `pretty_dio_logger` for logging HTTP requests.

- Local Storage: `shared_preferences` for local storage.

- TTS (Text to Speech): `flutter_tts` for text-to-speech functionality.

- Functional Programming: `dartz` for functional programming.

- Backend Integration: `firebase_auth`, `firebase_core`, and `cloud_firestore` for authentication and Firestore integration.

- UI Elements: `flutter_svg` for SVG images, `google_fonts` for Google Fonts, `vibration` for vibration effects, and `modal_bottom_sheet` for bottom sheets.

- Testing: `mockito` for mocking objects and `build_runner` for mockito code generation.

## APIs

The app integrates external APIs to provide comprehensive word data:

- [wordsapi](https://www.wordsapi.com/): API for retrieving word data and definitions.

- [firebase](https://firebase.google.com/): Firebase services for authentication and Firestore integration.

- [gpt-3](https://openai.com/blog/openai-api/): GPT-3 API for generating word suggestions.

## Requirements

To run the app, the following requirements must be met:

- Flutter 3.10.5

- Dart SDK version: '>=3.0.5 <4.0.0'

- Android SDK (for Android development)

## Getting Started

To get started with the app:

1. Clone the repository and navigate to the project directory.

2. Install the required packages using `flutter pub get`.

3. Activate code generation with `flutter pub run build_runner watch --delete-conflicting-outputs`.

4. Run the app with specific environment variables defined, including API keys for various services.

## Conclusion

The English Dictionary app is an ambitious project that aims to provide a robust and feature-rich experience for users seeking to explore English words, their meanings, and related suggestions. The implementation adheres to Clean Architecture principles, ensuring maintainability and scalability. With ongoing development and planned features, the app promises to evolve into a comprehensive tool for users looking to expand their vocabulary and language skills.
