To Run the app
# flutter pub run build_runner build --delete-conflicting-outputs

# flutter run -v

## Android Release Build for Google Play Store

### App Information
- **App Name**: Health Guide Clinic
- **Package Name**: com.HealthGuideClinic
- **Version**: 1.0.1
- **Version Code**: 1
- **Description**: A healthcare consultation app that connects patients with medical clinics, featuring secure authentication (Google & Facebook sign-in), real-time notifications via Firebase Cloud Messaging, and rich medical content display with Flutter Quill editor.

### Keystore Credentials
- **Keystore File**: `upload-keystore.jks` (located at project root)
- **Key Alias**: `upload`
- **Key Password**: `HealthGuide2026`
- **Store Password**: `HealthGuide2026`

### Keystore Generation Command
```bash
keytool -genkey -v -keystore upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload \
  -dname "CN=Health Guide Clinic, OU=Development, O=HealthGuide, L=City, ST=State, C=US" \
  -storepass HealthGuide2026 -keypass HealthGuide2026
```

### Key Properties Configuration
The keystore is configured via `android/key.properties`:
```
storePassword=HealthGuide2026
keyPassword=HealthGuide2026
keyAlias=upload
storeFile=../upload-keystore.jks
```

### Build Output
- **AAB File**: `build/app/outputs/bundle/release/app-release.aab`
- **Built On**: 2026-02-18
- **File Size**: 49.3MB

### Build Commands
```bash
# Build Android App Bundle (AAB) for Play Store
flutter build appbundle --release

# Build APK for testing
flutter build apk --release
```