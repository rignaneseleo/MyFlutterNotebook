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
# Lint
flutter pub add dev:very_good_analysis
flutter pub add dev:custom_lint

# State management: Riverpod
flutter pub add flutter_riverpod
flutter pub add riverpod_annotation
flutter pub add dev:riverpod_generator
flutter pub add dev:riverpod_lint

# Data classes: Freezed
flutter pub add freezed_annotation
flutter pub add json_annotation
flutter pub add dev:build_runner
flutter pub add dev:freezed
flutter pub add dev:json_serializable

# Routing: Go Router
flutter pub add auto_route

# Theming
flutter pub add flex_color_scheme

# Logging 
flutter pub add flutter_bugfender #todo signup and get key

# Envied for environment variables
flutter pub add envied
flutter pub add dev:envied_generator

# Icons and Splash Screen generators
flutter pub add dev:flutter_launcher_icons
flutter pub add dev:flutter_native_splash

# Misc
flutter pub add universal_platform
flutter pub add shared_preferences
flutter pub add permission_handler

# Other
flutter pub add share_plus
flutter pub add url_launcher
```

### Setting Up Linting
I use the following analysis_options.yaml file for linting:

```bash
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

#https://github.com/VeryGoodOpenSource/very_good_analysis/blob/main/lib/analysis_options.5.1.0.yaml
linter:
  rules:
    public_member_api_docs: false
    prefer_single_quotes: false
    no_leading_underscores_for_local_identifiers: false
```

### Disable other platforms

By default, Flutter enables web support. If you are not planning to use web, you can disable it to speed up the build process:
```bash
flutter config --no-enable-web
rm -rf web
```

You can also disable other platforms like macOS, Linux, and Windows if you are not planning to use them.
Run `flutter config` to see the available options.

### Using FVM

I highly recommend using [FVM](https://fvm.app/) and [Sidekick](https://github.com/fluttertools/sidekick) to manage Flutter versions for each project. This ensures your projects stay futureproof and stick with a defined Flutter version.

For example, to use the stable version of Flutter in a project:
```bash
fvm use stable
```

But you can also use a specific version of Flutter:
```bash
fvm use 3.20.0
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

### Create a Flutter Scope
When you are searching for a piece of code or a file, you can create a Flutter scope to search only within the Flutter files that matter. To do this, go to `Edit > Find > Find in Path` and click on the `...` button next to the `Scope` field. Then, click on the `+` button and select `Local` to create a new scope. 

Add the following patterns to the scope, replacing *project_name* with the name of your project:

```
file[*project_name*]:lib//*&&!file:*.g.dart&&!file:*.gr.dart&&!file:*.freezed.dart 
```