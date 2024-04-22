# Firebase Chat App with Flutter & Riverpod

This is a basic chat application built with Flutter for mobile and Firebase for backend services. It utilizes Riverpod for state management.

# Features
*  ***User Authentication***: Users can sign up and log with google and logout.
* ***Contact List***: Users can see a list of other registered users.
* ***Chat Screen***: Users can chat with each other in real-time.
* ***Push Notifications***: Users receive notifications for new messages.

# Demonstration
Here is a video demonstration of the application
[![Video Demonstration (https://img.youtube.com/vi/2644ppEqqUM/0.jpg)](https://www.youtube.com/watch?v=2644ppEqqUM)

[![Rick Astley - Never Gonna Give You Up](https://img.youtube.com/vi/2644ppEqqUM/0.jpg)](https://www.youtube.com/watch?v=2644ppEqqUM)

# Running the app
The app designed in such a way that it can have multiple build environment.
For our purposes, we have configured only one environment eg. development

The development build environment entry point is located in 
```agsl
lib/config/environment/env_development.dart
```

To run the application, one can use the following flutter command

```agsl
flutter run --target lib/config/environment/env_development.dart
```


# Code structure
This project demonstrates a feature-first approach to clean architecture using Flutter. It prioritizes separation of concerns and makes it easy to switch out backend implementations without affecting the presentation and domain layers.

### Feature-First Approach 
This project builds features independently, each following the clean architecture structure. This allows for:
* ***Incremental Development***: Features can be developed and tested in isolation.
* ***Easier Maintenance***: Changes to a specific feature are less likely to impact other parts of the application.

### Firebase Agnostic Design
The presentation and domain layers are designed to be independent of Firebase. This means:
* ***No Firebase dependencies***: These layers don't reference any Firebase-specific classes or functions.
* ***Abstracted Data Access***: The repository provides an interface for data access, allowing for alternative implementations (e.g., local storage).

### Implementing a New Data Source
If you don't want to use Firebase, you only need to modify the data source layer:
* Implement a new concrete data source class that interacts with your chosen persistence solution.
* Update the repository to use the new data source implementation.
* The presentation and domain layers remain completely unaffected.

