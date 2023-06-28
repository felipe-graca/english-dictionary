# english_dictionary

<!-- Create a complete descript -->
This application is a simple english dictionary application built using flutter framework. This application is built using BLoC pattern, Clean Architecture, TDD, and SOLID principle.

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
            - errors
            - features
                - cubit
                - data
                    - datasources
                    - models
                    - repositories
                - domain
                    - entities
                    - repositories
                    - usecases
            - routes
            - usecase
            - utils
            - services
            - shared
        - presenter
            - features
                - cubit
                - data
                    - datasources
                    - models
                    - repositories
                - domain
                    - entities
                    - repositories
                    - usecases
                - pages
                    - widgets
        - ui
            - global
                - custom_components
                    - widgets
                    - cubit
        - main.dart
                

            





## Getting Started

### 1. Clone the repository

```shell
$ git clone
$ cd english_dictionary
```

### 2. Get the packages

```shell
$ flutter pub get
```

### 3. Active code generation

```shell
$ flutter pub run build_runner watch --delete-conflicting-outputs
```

- You need to run this command what ever you change the code in test folder [Mockito]


### 4. Run the app

```shell
$ flutter run
```

## Screenshots
- Figma design(UI/UX) created by me

![Alt Text](images/figma.png)


