# noteit

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# NoteIt - Your Cross-Platform Notes App

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![GitHub Actions - Build Android](https://github.com/pyapril15/noteit/workflows/Build%20Android/badge.svg)](https://github.com/pyapril15/noteit/actions/workflows/android.yml)

NoteIt is a feature-rich, cross-platform notes application built with Flutter, designed to seamlessly capture your thoughts, ideas, and to-do lists. Currently supporting Android, with future plans for macOS, iOS, and Windows.

## Features

* **Cross-Platform (Future):** Planned support for macOS, iOS, and Windows in addition to current Android support.
* **User Authentication:** Securely log in and sign up with email verification.
* **Rich Text Editing:** Customize your notes with bold, italic, underline, font size, color, and alignment options.
* **Theme Customization:** Switch between light and dark modes for comfortable reading.
* **Secure Data Storage:** User data is securely stored using Firebase and SQLite.
* **"Remember Me" Functionality:** Securely save your login credentials for quick access.
* **Profile Management:** Update your profile details, including name, date of birth, state, and city.
* **Profile Picture Upload:** Add a personal touch by uploading your profile picture.
* **Forgot Password and Resend Verification Email:** Recover your account or resend verification emails easily.

## Screenshots

*(Include screenshots of your app on Android here. Update with other platforms as they are added.)*

| Android |
| :------: |
| <img src="assets/screenshots/android_screenshot.png" alt="Android Screenshot" width="300"/> |

## Getting Started

### Prerequisites

* Flutter SDK (version 3.10 or later)
* Android Studio
* Firebase project configured for your app

### Installation

1.  Clone the repository:

    ```bash
    git clone [https://github.com/pyapril15/noteit.git](https://www.google.com/search?q=https://github.com/pyapril15/noteit.git)
    ```

2.  Navigate to the project directory:

    ```bash
    cd noteit
    ```

3.  Install dependencies:

    ```bash
    flutter pub get
    ```

4.  Configure Firebase:
    * Download the `google-services.json` file from your Firebase project.
    * Place it in the `android/app/` directory.

5.  Run the app on an Android device or emulator:

    ```bash
    flutter run
    ```

### Building for Release

* **Android:**
    * Generate a signed APK or AAB.
    * Use GitHub Actions to automate the build and signing process.

### GitHub Actions

This project uses GitHub Actions for continuous integration and deployment. The following workflow is configured:

* **Build Android:** Builds and signs the Android app.

### Future Enhancements

* **macOS, iOS, and Windows Support:** Expanding the app to other platforms.
* **Cloud Sync:** Sync notes across devices.
* **Collaboration Features:** Allow multiple users to collaborate on notes.
* **Advanced Search:** Implement robust search functionality.
* **Reminders and Notifications:** Add reminders and notifications for notes.

### Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue.

### License

This project is licensed under the [MIT License](LICENSE).

### Contact

For any inquiries, please contact [praveen.yadav.codelab@gmail.com](mailto:praveen.yadav.codelab@gmail.com).

**Author:** Praveen Yadav
**Organization:** codelabpraveen