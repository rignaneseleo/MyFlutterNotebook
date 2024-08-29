# 🚀 Leorigna's Flutter Notebook

Welcome to my open notebook for Flutter! Here, I'll be compiling notes, code snippets, and useful information as I continue learning and using Flutter. Let's build amazing apps together! 🌟

*Last update: 26 August 2024*

## 📚 Table of Contents

- [My Template Setup](#-template-setup)
- [New Flutter Project Setup](#-new-flutter-project-setup)
  - [Starting a Project](#starting-a-project)
  - [Installing Essential Libraries](#installing-essential-libraries)
  - [Setting Up Linting](#setting-up-linting)
  - [Disable Other Platforms](#disable-other-platforms)
  - [Using FVM](#using-fvm)
  - [Setting Up FlutterFire](#setting-up-flutterfire)
- [Android Studio Tips](#-android-studio-tips)


---

## 🧩 Template Setup

Get started with this template in two easy steps:

1. Download this repository
2. Run the setup script:

```bash
chmod +x rename_template.sh
./rename_template.sh com.org.name "My App Name"
```

Once the script is done, you can start your project with:
 - Install [FVM](https://fvm.app/)
 - Create the `.env` file with the environment variables in the *root folder* (see .env.example)
 - Run `fvm dart run  build_runner watch --delete-conflicting-outputs` to generate the code
 - Edit or delete the project README.md file

## 🔧 New Flutter Project Setup

### Starting a Project

Begin your Flutter journey with a clean slate:

```bash
flutter create project_name --empty
```

### Installing Essential Libraries

Supercharge your project with these must-have packages:

<details>
<summary>Click to expand the list of essential libraries</summary>

```bash
# Linting
flutter pub add dev:very_good_analysis dev:custom_lint

# State management: Riverpod
flutter pub add flutter_riverpod riverpod_annotation
flutter pub add dev:riverpod_generator dev:riverpod_lint

# Data classes: Freezed
flutter pub add freezed_annotation json_annotation
flutter pub add dev:build_runner dev:freezed dev:json_serializable

# Routing
flutter pub add auto_route dev:auto_route_generator

# Style
flutter pub add flex_color_scheme google_fonts

# Logging 
flutter pub add flutter_bugfender #todo signup and get key

# Environment variables
flutter pub add envied dev:envied_generator

# Icons and Splash Screen generators
flutter pub add dev:flutter_launcher_icons dev:flutter_native_splash

# Misc
flutter pub add package_info_plus universal_platform shared_preferences permission_handler 

# Translation
flutter pub add easy_localization flutter_localization

# Style

# Other
flutter pub add share_plus url_launcher
```

</details>

### Setting Up Linting

Ensure code quality with this `analysis_options.yaml`:

<details>
<summary>Click to view the linting configuration</summary>

```yaml
include: package:very_good_analysis/analysis_options.yaml

analyzer:
  language:
    strict-casts: true
    strict-inference: true
    strict-raw-types: true

  errors:
    close_sinks: ignore
    missing_required_param: error
    missing_return: error
    record_literal_one_positional_no_trailing_comma: error
    collection_methods_unrelated_type: warning
    unrelated_type_equality_checks: warning

  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
    - test/.test_coverage.dart
    - lib/generated_plugin_registrant.dart

  plugins:
    - custom_lint

linter:
  rules:
    public_member_api_docs: false
    prefer_single_quotes: false
    no_leading_underscores_for_local_identifiers: false
```

</details>

### Disable Other Platforms

Optimize your build process by disabling unused platforms:

```bash
flutter config --no-enable-web
rm -rf web
```

### Using FVM

Manage Flutter versions like a pro with [FVM](https://fvm.app/) and [Sidekick](https://github.com/fluttertools/sidekick):

```bash
fvm use stable
# or
fvm use 3.20.0
```

### Setting Up FlutterFire

FlutterFire CLI is a command-line tool that helps you set up Firebase in your Flutter projects: https://firebase.flutter.dev/

After installing the FlutterFire CLI, run the following command to set up Firebase in your project:

```bash
flutterfire configure
```

This will create a `firebase_options.dart` file in your project containing the Firebase options for the platform you are building for.

In your flutter app main.dart you can simply use:

```dart
import 'firebase_options.dart';

// ...

await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

---
---

## 🎨 Android Studio Tips

### Hiding Unnecessary Files

Keep your project view clean with these file nesting patterns:

```
.chopper.dart
.dart.js
.dart.js.deps
.dart.js.map
.dart.js.tar.gz
.freezed.dart
.g.dart
.gr.dart
.module
.realm.dart
```

### Create a Flutter Scope

Streamline your searches with a custom Flutter scope:

```
file[*project_name*]:lib//*&&!file:*.g.dart&&!file:*.gr.dart&&!file:*.freezed.dart 
```


---

Happy coding! 🎉 If you find this notebook helpful, don't forget to star the repo and share it with your fellow Flutter enthusiasts!