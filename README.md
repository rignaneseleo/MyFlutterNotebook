# Leorigna's Flutter Notebook

Welcome to my open notebook for Flutter! Here, I'll be compiling notes, code snippets, and useful information as I continue learning and using Flutter.

*Last update: 11 July 2024*

## New Flutter Project Setup

### Starting a Project

To begin a new project without the default example:

```bash
flutter create *project_name* --empty
```

### Installing Essential Libraries

For every new project, ensure these essential libraries are installed with the latest versions:

```bash
# Freezed
flutter pub add freezed_annotation
flutter pub add json_annotation
flutter pub add dev:build_runner
flutter pub add dev:freezed
flutter pub add dev:json_serializable

# Riverpod
flutter pub add riverpod
flutter pub add riverpod_annotation
flutter pub add dev:riverpod_generator
flutter pub add dev:riverpod_lint
flutter pub add dev:custom_lint

# Router
flutter pub add go_router

# Lint
flutter pub add dev:flutter_lints

# Theme
flutter pub add flex_color_scheme

# Others
flutter pub add shared_preferences
flutter pub add dev:flutter_launcher_icons
```

### Using FVM

I highly recommend using [FVM](https://fvm.app/) and [Sidekick](https://github.com/fluttertools/sidekick) to manage Flutter versions for each project. This ensures your projects remain compatible and avoids version conflicts.

```bash
fvm use stable
```

## Android Studio Tips

### Hiding Unnecessary Files

To tidy up your project view by hiding unnecessary files, add the following patterns to `Project > Options > FileNesting`:

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