# english_dictionary

Application for challange interview

- This application is a simple english dictionary application
- This application is built using flutter framework
- This application is built using BLoC pattern
- This application is built using Clean Architecture
- This application is built using TDD
- This application is built using SOLID principle

## Packages
- [get_it](https://pub.dev/packages/get_it) - For dependency injection
- [equatable](https://pub.dev/packages/equatable) - For equality comparison
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) - For state management
- [http](https://pub.dev/packages/http) - For http request
- [mockito](https://pub.dev/packages/mockito) - For mocking object
- [shared_preferences](https://pub.dev/packages/shared_preferences) - For local storage
- [build_runner](https://pub.dev/packages/build_runner) - For mockito code generation
- [firebase_auth](https://pub.dev/packages/firebase_auth) - For authentication
- [firebase_core](https://pub.dev/packages/firebase_core) - For firebase core
- [cloud_firestore](https://pub.dev/packages/cloud_firestore) - For firebase firestore


## Architecture
    - lib
        - core
            - error
            - usecase
            - util
        - data
            - datasource
            - model
            - repository
        - domain
            - entity
            - repository
            - usecase
        - presentation
            - bloc
            - page
            - widget
        - main.dart



## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
