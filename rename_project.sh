#!/bin/bash

# Check if all arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <new_package_name> <new_display_name>"
    echo "Example: $0 com.example.myapp 'My App'"
    exit 1
fi

new_package_name=$1
new_display_name=$2
old_name=my_template

# Derive new project name from package name (last part)
new_name=$(echo $new_package_name | rev | cut -d. -f1 | rev)

# Rename directory
mv $old_name $new_name
cd $new_name

# Update pubspec.yaml
sed -i '' "s/name: $old_name/name: $new_name/" pubspec.yaml

# Update Android files
sed -i '' "s/applicationId \".*\"/applicationId \"$new_package_name\"/" android/app/build.gradle
old_package_path=$(find android/app/src/main/kotlin -type d -not -path '*/\.*' | grep -v 'kotlin$' | head -1)
new_package_path="android/app/src/main/kotlin/$(echo $new_package_name | sed 's/\./\//g')"
mkdir -p "$new_package_path"
mv $old_package_path/* "$new_package_path/"
rm -rf $(dirname "$old_package_path")
find android -type f -exec sed -i '' "s/package=\".*\"/package=\"$new_package_name\"/g" {} +
find android -type f -exec sed -i '' "s/package .*;/package $new_package_name;/g" {} +

# Update iOS files
sed -i '' "s/PRODUCT_BUNDLE_IDENTIFIER = .*;/PRODUCT_BUNDLE_IDENTIFIER = $new_package_name;/" ios/Runner.xcodeproj/project.pbxproj
sed -i '' "s/PRODUCT_NAME = .*/PRODUCT_NAME = \"$new_display_name\";/" ios/Runner.xcodeproj/project.pbxproj
sed -i '' "s/CFBundleName\">.*/CFBundleName\">\$(PRODUCT_NAME)<\/string>/" ios/Runner/Info.plist
sed -i '' "s/CFBundleDisplayName\">.*/CFBundleDisplayName\">$new_display_name<\/string>/" ios/Runner/Info.plist

# Update macOS files (if exists)
if [ -d "macos" ]; then
    sed -i '' "s/PRODUCT_BUNDLE_IDENTIFIER = .*;/PRODUCT_BUNDLE_IDENTIFIER = $new_package_name;/" macos/Runner.xcodeproj/project.pbxproj
    sed -i '' "s/PRODUCT_NAME = .*/PRODUCT_NAME = \"$new_display_name\";/" macos/Runner.xcodeproj/project.pbxproj
    sed -i '' "s/CFBundleName\">.*/CFBundleName\">\$(PRODUCT_NAME)<\/string>/" macos/Runner/Info.plist
    sed -i '' "s/CFBundleDisplayName\">.*/CFBundleDisplayName\">$new_display_name<\/string>/" macos/Runner/Info.plist
fi

# Global search and replace
find . -type f -not -path '*/\.*' -exec sed -i '' "s/$old_name/$new_name/g" {} +
find . -type f -not -path '*/\.*' -exec sed -i '' "s/com.example.$old_name/$new_package_name/g" {} +

# Update app title in lib/main.dart
sed -i '' "s/title: '.*'/title: '$new_display_name'/" lib/main.dart

# Clean and get packages
flutter clean
flutter pub get

echo "Project renamed from $old_name to $new_name"
echo "Package name set to $new_package_name"
echo "Display name set to '$new_display_name'"
echo "Please review changes and run 'flutter create .' to regenerate platform-specific files if needed."