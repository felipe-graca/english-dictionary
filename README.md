# English dictionary

This is a simple english word dictionary app. With GPT-3, the app will suggest you a list of words that you may like. You can also search for words and save them to your favorite list. The app also has a history list that you can see the words you have viewed. You can also see the total number of words you have viewed. The app also has a profile page that you can see your lastest viewed words and your favorite words.

<!-- Create Warning text for excessive architecture complexition for Knowledge demonstration and i know to the Repository bypass rule(80% - 20%) -->
## ATENTITION

- This application is created using Clean Architecture and Clean Code
- This application is created using DDD+TDD
- This application is created using SOLID principles
- I know the Repository bypass rule(80% - 20%) but i want to demonstrate my knowledge about Clean Architecture and Clean Code
- Desconsider the complexity of the architecture, i know that this application is simple and the architecture is complex, but i want to demonstrate my knowledge about Clean Architecture and Clean Code





## Screenshots
Figma design(UI/UX) created by me

![Alt Text](images/figma.png)

## Packages and usage

#### Dependency injection
- [get_it](https://pub.dev/packages/get_it) - For dependency injection

#### Equatablity and state management
- [equatable](https://pub.dev/packages/equatable) - For equality comparison
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) - For state management

#### Rest Service
- [dio](https://pub.dev/packages/dio) - For http request
- [pretty_dio_logger](https://pub.dev/packages/pretty_dio_logger) - For logging http request

#### Local storage
- [shared_preferences](https://pub.dev/packages/shared_preferences) - For local storage

#### TTS (Text to speech)
- [flutter_tts](https://pub.dev/packages/flutter_tts) - For text to speech

#### Functional programming
- [dartz](https://pub.dev/packages/dartz) - For functional programming

#### Back-end
- [firebase_auth](https://pub.dev/packages/firebase_auth) - For authentication
- [firebase_core](https://pub.dev/packages/firebase_core) - For firebase core
- [cloud_firestore](https://pub.dev/packages/cloud_firestore) - For firebase firestore

#### UI
- [flutter_svg](https://pub.dev/packages/flutter_svg) - For svg image
- [google_fonts](https://pub.dev/packages/google_fonts) - For google fonts
- [vibration](https://pub.dev/packages/vibration) - For vibration effect
- [modal_bottom_sheet](https://pub.dev/packages/modal_bottom_sheet) - For bottom sheet

#### Testing
- [mockito](https://pub.dev/packages/mockito) - For mocking object
- [build_runner](https://pub.dev/packages/build_runner) - For mockito code generation



## Architecture
    - lib
        - core
            - errors
            - features
                - feature
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
            - services
            - utils
            - shared ### in the future this folder was deleted
        - presenters
            - presenter
                - page
                - widgets
        - ui ### in the future this folder was transfered to Design System
            - components
                - light_components
                - dark_components
            - shared
                - Automatic select components based on theme
            - configurations
        - main.dart
                

## APIS
- [wordsapi](https://www.wordsapi.com/)
- [firebase](https://firebase.google.com/)

## Features
- [X] Search word
- [X] Save word to favorite list
- [X] Save word to history list
- [X] Text to speech word
- [X] Login with google
- [X] Logout
- [X] View favorite words
- [X] View history words
- [X] View profile
- [X] View total number of new words viewed
- [X] Edit image profile
- [...] Search Word (In progress)
- [...] Related Suggest words with GPT-3 (In progress)
- [...] Dark mode (To Do)
- [...] Gamefication (To Do)
- [...] Search word with voice (To Do)
- [...] Search word with camera (To Do)



## Testing
- [X] Unit Testing


## Requirements
- [Flutter](https://flutter.dev/docs/get-started/install) 3.10.5
- [Dart](https://dart.dev/) sdk: '>=3.0.5 <4.0.0'
- [Android SDK](https://developer.android.com/studio)


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

- You need run this command what ever you change the code in test folder [Mockito]


### 4. Run the app

```shell
$ flutter run --dart-define=WORD_SIGNIFICATION_API_KEY=[YOUR_API_KEY] --dart-define=WORD_SIGNIFICATION_API_URL=https://wordsapiv1.p.rapidapi.com/words --dart-define=STORAGE_BUCKET=[STORAGE_BUCKET_URL] --dart-define=GPT_API_URL=https://api.openai.com/v1/engines/davinci/completions --dart-define=GPT_API_KEY=[key]
```

