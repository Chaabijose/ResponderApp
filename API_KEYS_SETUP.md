# Google Maps API Keys Setup

This project uses Google Maps and requires API keys for both iOS and Android platforms.

## Security Notice
API keys are stored in separate configuration files and are excluded from version control for security.

## Setup Instructions

### 1. Get Google Maps API Keys
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing project
3. Enable Google Maps SDK for iOS and Android
4. Create API keys with appropriate restrictions

### 2. iOS Setup
1. Copy `ios/Runner/GoogleService-Info.plist.template` to `ios/Runner/GoogleService-Info.plist`
2. Replace `YOUR_GOOGLE_MAPS_API_KEY_HERE` with your actual iOS API key
3. The AppDelegate.swift will automatically read the key from this file

### 3. Android Setup
1. Copy `android/app/src/main/res/values/google_maps_api.xml.template` to `android/app/src/main/res/values/google_maps_api.xml`
2. Replace `YOUR_GOOGLE_MAPS_API_KEY_HERE` with your actual Android API key
3. The AndroidManifest.xml will automatically reference this resource

### 4. API Key Restrictions (Recommended)
- **iOS API Key**: Restrict to iOS apps with your bundle identifier
- **Android API Key**: Restrict to Android apps with your package name and SHA-1 certificate fingerprint

### 5. Files Structure
```
ios/Runner/
├── GoogleService-Info.plist          # Your actual API key (gitignored)
└── GoogleService-Info.plist.template # Template for other developers

android/app/src/main/res/values/
├── google_maps_api.xml          # Your actual API key (gitignored)
└── google_maps_api.xml.template # Template for other developers
```

## Important Notes
- Never commit actual API keys to version control
- Use different API keys for development and production
- Set up proper API key restrictions in Google Cloud Console
- The actual API key files are automatically excluded from git commits
