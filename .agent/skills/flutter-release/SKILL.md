---
name: flutter-release
description: Build and release Flutter apps. Use for building APK, AAB, Shorebird release, or Shorebird patch. Handles version bumping and moves output to Desktop.
---

# Flutter Release Build

Build Flutter releases (APK/AAB) with optional Shorebird integration.

## When to use this skill

- User asks to "build a release APK"
- User asks to "build with Shorebird"
- User asks to "build an app bundle"
- User asks to "patch with Shorebird"

## How to use it

### Step 1: Bump Version

**For builds (APK, AAB, Shorebird release):** Increment the build number in `pubspec.yaml`.

Example: `version: 1.0.0+5` → `version: 1.0.0+6`

**For Shorebird patch:** Skip this step. Patches use the existing version.

### Step 2: Build

| Build Type | Command |
|------------|---------|
| APK (Flutter) | `flutter clean && flutter pub get && flutter build apk --release` |
| APK (Shorebird) | `flutter clean && flutter pub get && shorebird release android --artifact apk` |
| AAB (Bundle) | `flutter clean && flutter pub get && flutter build appbundle --release` |
| Shorebird Patch | `shorebird patch android` |

### Step 3: Move & Rename

Move output to Desktop with this naming:

| Build Type | Pattern | Example |
|------------|---------|---------|
| APK (Flutter) | `<name>(<version>).apk` | `bac(1.0.0+6).apk` |
| APK (Shorebird) | `<name>-sp(<version>).apk` | `bac-sp(1.0.0+6).apk` |
| AAB (Bundle) | `<name>(<version>).aab` | `bac(1.0.0+6).aab` |

Output paths:
- APK: `build/app/outputs/flutter-apk/app-release.apk`
- AAB: `build/app/outputs/bundle/release/app-release.aab`

Get project name from `name:` field in `pubspec.yaml`.
