# Src Directory

This folder contains the main features that are directly accessed and used by application users. Each subfolder within `src` represents a major module within the application's structure.

Currently, the folders include:

- **auth**: Handles user authentication processes (login, registration, etc.).
- **learning**: Deals with learning and educational flows within the app.
- **onboarding**: Manages the onboarding flow for new users.
- **settings**: Contains user and application settings/configuration screens and logic.
- **splash**: Handles the splash screen displayed during application startup.

Each directory is responsible for an isolated part of the app's user-facing experience. New user features should be added in new or existing subfolders according to their domain within the application.

Additionally, each feature within the `src` directory follows a structure divided into three main parts:

- **ViewModel**: Responsible for modeling the page's data and managing the state. This is where the data that may change over time lives, and it notifies the UI when changes happen.
- **ViewController**: Contains the business logic for the screen, meaning the functions and logic that are executed when the user interacts with the interface (for example, when clicking a button).
- **View**: Responsible for the visual construction of the page (widgets), consuming the ViewModel and calling functions from the ViewController as needed.

This separation helps keep responsibilities divided, makes maintenance easier, and keeps the code more organized.