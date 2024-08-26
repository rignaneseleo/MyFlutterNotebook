#!/bin/bash

set -e

log_error() {
    echo "ERROR: $1" >&2
}

log_info() {
    echo "INFO: $1"
}

# Set old_name as a constant
old_name="my_template"

# Check if all arguments are provided
if [ "$#" -ne 2 ]; then
    log_error "Usage: $0 <new_package_name> <new_display_name>"
    log_error "Example: $0 com.example.myapp 'My App'"
    exit 1
fi

new_package_name=$1
new_display_name=$2

# Derive new project name from package name (last part)
new_name=$(echo $new_package_name | rev | cut -d. -f1 | rev)

log_info "Starting rename process..."
log_info "New package name: $new_package_name"
log_info "New display name: $new_display_name"
log_info "Old project name: $old_name"
log_info "New project name: $new_name"

# Rename directory
if [ -d "$old_name" ]; then
    log_info "Renaming project directory..."
    mv "$old_name" "$new_name" || log_error "Failed to rename project directory"
    cd "$new_name" || log_error "Failed to change to new project directory"
else
    log_info "Directory $old_name not found. Assuming we're already in the project directory."
fi

# Update pubspec.yaml
log_info "Updating pubspec.yaml..."
sed -i.bak "s/name: $old_name/name: $new_name/" pubspec.yaml && rm pubspec.yaml.bak || log_error "Failed to update pubspec.yaml"

# Update Android files
log_info "Updating Android files..."
sed -i.bak "s/applicationId \".*\"/applicationId \"$new_package_name\"/" android/app/build.gradle && rm android/app/build.gradle.bak || log_error "Failed to update build.gradle"
sed -i.bak "s/com\.example\.$old_name/$new_package_name/g" android/app/build.gradle && rm android/app/build.gradle.bak || log_error "Failed to update old package name in build.gradle"

# Find and update Kotlin files
log_info "Updating Kotlin files..."
find android/app/src/main/kotlin -type f -name "*.kt" | while read -r file; do
    log_info "Processing Kotlin file: $file"
    sed -i.bak "s/^package .*/package $new_package_name/" "$file" && rm "${file}.bak" || log_error "Failed to update package in $file"
    new_dir=$(dirname "$file" | sed "s|com/example/$old_name|$(echo $new_package_name | sed 's/\./\//g')|g")
    log_info "Creating new directory: $new_dir"
    mkdir -p "$new_dir" || log_error "Failed to create directory $new_dir"
    log_info "Moving file to new directory"
    mv "$file" "$new_dir/" || log_error "Failed to move $file to $new_dir"
done

# Clean up old directories
log_info "Cleaning up old directories..."
find android/app/src/main/kotlin -type d -empty -delete

# Update AndroidManifest.xml
log_info "Updating AndroidManifest.xml..."
sed -i.bak "s/package=\".*\"/package=\"$new_package_name\"/" android/app/src/main/AndroidManifest.xml && rm android/app/src/main/AndroidManifest.xml.bak || log_error "Failed to update AndroidManifest.xml"
sed -i.bak "s/com\.example\.$old_name/$new_package_name/g" android/app/src/main/AndroidManifest.xml && rm android/app/src/main/AndroidManifest.xml.bak || log_error "Failed to update old package name in AndroidManifest.xml"
sed -i.bak "s/android:label=\".*\"/android:label=\"$new_display_name\"/" android/app/src/main/AndroidManifest.xml && rm android/app/src/main/AndroidManifest.xml.bak || log_error "Failed to update android:label in AndroidManifest.xml"

# Update iOS files
log_info "Updating iOS files..."
sed -i.bak "s/PRODUCT_BUNDLE_IDENTIFIER = .*/PRODUCT_BUNDLE_IDENTIFIER = $new_package_name;/" ios/Runner.xcodeproj/project.pbxproj && rm ios/Runner.xcodeproj/project.pbxproj.bak || log_error "Failed to update iOS bundle identifier"
sed -i.bak "s/PRODUCT_NAME = .*/PRODUCT_NAME = \"$new_display_name\";/" ios/Runner.xcodeproj/project.pbxproj && rm ios/Runner.xcodeproj/project.pbxproj.bak || log_error "Failed to update iOS product name"

if command -v plutil &> /dev/null; then
    plutil -replace CFBundleName -string "$new_display_name" ios/Runner/Info.plist || log_error "Failed to update CFBundleName in Info.plist"
    plutil -replace CFBundleDisplayName -string "$new_display_name" ios/Runner/Info.plist || log_error "Failed to update CFBundleDisplayName in Info.plist"
else
    log_error "plutil command not found. Please manually update ios/Runner/Info.plist"
fi

# Update macOS files (if exists)
if [ -d "macos" ]; then
    log_info "Updating macOS files..."
    sed -i.bak "s/PRODUCT_BUNDLE_IDENTIFIER = .*/PRODUCT_BUNDLE_IDENTIFIER = $new_package_name;/" macos/Runner.xcodeproj/project.pbxproj && rm macos/Runner.xcodeproj/project.pbxproj.bak || log_error "Failed to update macOS bundle identifier"
    sed -i.bak "s/PRODUCT_NAME = .*/PRODUCT_NAME = \"$new_display_name\";/" macos/Runner.xcodeproj/project.pbxproj && rm macos/Runner.xcodeproj/project.pbxproj.bak || log_error "Failed to update macOS product name"
    
    if command -v plutil &> /dev/null; then
        plutil -replace CFBundleName -string "$new_display_name" macos/Runner/Info.plist || log_error "Failed to update CFBundleName in macOS Info.plist"
        plutil -replace CFBundleDisplayName -string "$new_display_name" macos/Runner/Info.plist || log_error "Failed to update CFBundleDisplayName in macOS Info.plist"
    else
        log_error "plutil command not found. Please manually update macos/Runner/Info.plist"
    fi
fi

# Global search and replace
log_info "Performing global search and replace..."
find . -type f -not -path '*/\.*' -not -name "*.bak" | xargs sed -i.bak "s/$old_name/$new_name/g" && find . -name "*.bak" -type f -delete || log_error "Failed during global search and replace for project name"
find . -type f -not -path '*/\.*' -not -name "*.bak" | xargs sed -i.bak "s/com\.example\.$old_name/$new_package_name/g" && find . -name "*.bak" -type f -delete || log_error "Failed during global search and replace for package name"

# Update import statements
log_info "Updating import statements..."
find . -type f -name "*.dart" | xargs sed -i.bak "s/import 'package:$old_name/import 'package:$new_name/g" && find . -name "*.bak" -type f -delete || log_error "Failed to update import statements"

# Update app title in lib/main.dart
log_info "Updating app title in lib/main.dart..."
sed -i.bak "s/title: '.*'/title: '$new_display_name'/" lib/main.dart && rm lib/main.dart.bak || log_error "Failed to update app title in lib/main.dart"

# Update kAppTitle in consts.dart
log_info "Updating kAppTitle in consts.dart..."
sed -i.bak "s/const String kAppTitle = 'Leorigna Template';/const String kAppTitle = '$new_display_name';/" lib/core/config/consts.dart && rm lib/core/config/consts.dart.bak || log_error "Failed to update kAppTitle in consts.dart"

# Clean and get packages
log_info "Running flutter clean..."
flutter clean || log_error "Failed to run flutter clean"

log_info "Running flutter pub get..."
flutter pub get || log_error "Failed to run flutter pub get"

log_info "Project renamed from $old_name to $new_name"
log_info "Package name set to $new_package_name"
log_info "Display name set to '$new_display_name'"
log_info "Please review changes and run 'flutter create .' to regenerate platform-specific files if needed."