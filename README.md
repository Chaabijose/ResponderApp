# 🚨 First Responder App

A Flutter-based mobile application designed for first responders and emergency services personnel to manage unit status, track locations, handle emergency communications, and coordinate field operations.

---

## 📖 Overview

The **First Responder App** is a comprehensive emergency response management system that enables field officers to:

- Track real-time unit locations and status  
- Manage shift operations and unit assignments  
- Handle emergency communications and broadcasts  
- Access incident reports and field data  
- Coordinate with dispatch centers  

---

## ✨ Features

### 🔑 Core Functionality
- Authentication & Unit Selection: Secure login with unit assignment  
- Real-time Location Tracking: GPS-based unit positioning with Google Maps integration  
- Status Management: Update unit availability and operational status  
- Emergency Protocols: Two-finger emergency gesture for urgent situations  
- Offline Support: Cached map data and essential functions work offline  
- Multi-language Support: English and Arabic localization  

### 🖥️ User Interface
- Responsive Design: Optimized for both phones and tablets  
- Dark/Light Theme: Automatic theme switching based on preferences  
- Interactive Maps: Google Maps with custom markers and location services  
- Intuitive Navigation: Bottom sheets and slide-out panels for easy access  

### 🚨 Emergency Features
- Unit in Danger: Quick SOS activation with location broadcasting  
- Secure Communications: Encrypted messaging between units and dispatch  
- Incident Management: Create, update, and track field incidents  
- Shift Logging: Automated shift tracking and reporting  

---

## 🛠️ Technology Stack

- **Framework**: Flutter 3.x  
- **State Management**: GetX  
- **Architecture**: Clean Architecture with Repository Pattern  
- **Maps**: Google Maps Flutter  
- **Storage**: GetStorage (local) + secure preferences  
- **Networking**: Dio HTTP client with logging  
- **Authentication**: JWT token-based authentication  
- **Location Services**: Flutter Location plugin  
- **Permissions**: Flutter Permission Handler  

---

## 📦 Prerequisites

Before running the application, ensure you have:

- Flutter SDK (>=3.5.3)  
- Dart SDK (>=3.8.0)  
- Android Studio or VS Code with Flutter extensions  
- Xcode (for iOS development)  
- Google Maps API keys for both Android and iOS  
- Valid server configuration  

---

## 🚀 Installation

### 1. Clone the Repository
```bash
git clone <repository-url>
cd responder_app
---
### 2.Install Dependencies
flutter pub get

### 3.Project Structure
└── chaabijose-responderapp/
    ├── README.md
    ├── analysis_options.yaml
    ├── API_KEYS_SETUP.md
    ├── pubspec.lock
    ├── pubspec.yaml
    ├── .metadata
    ├── android/
    │   ├── app/
    │   │   ├── development.jks
    │   │   ├── production.jks
    │   │   └── src/
    │   │       ├── debug/
    │   │       │   └── AndroidManifest.xml
    │   │       ├── main/
    │   │       │   ├── AndroidManifest.xml
    │   │       │   ├── assets/
    │   │       │   │   └── offline_style.json
    │   │       │   ├── kotlin/
    │   │       │   │   └── com/
    │   │       │   │       └── geolab/
    │   │       │   │           └── responder_app/
    │   │       │   │               └── MainActivity.kt
    │   │       │   └── res/
    │   │       │       ├── drawable/
    │   │       │       │   └── launch_background.xml
    │   │       │       ├── drawable-v21/
    │   │       │       │   └── launch_background.xml
    │   │       │       ├── values/
    │   │       │       │   ├── google_maps_api.xml
    │   │       │       │   └── styles.xml
    │   │       │       └── values-night/
    │   │       │           └── styles.xml
    │   │       └── profile/
    │   │           └── AndroidManifest.xml
    │   └── gradle/
    │       └── wrapper/
    │           └── gradle-wrapper.properties
    ├── assets/
    │   ├── animations/
    │   │   └── success.json
    │   └── json/
    │       ├── config-prod.json
    │       └── config.json
    ├── ios/
    │   ├── Podfile
    │   ├── Flutter/
    │   │   ├── AppFrameworkInfo.plist
    │   │   ├── Debug.xcconfig
    │   │   └── Release.xcconfig
    │   ├── Runner/
    │   │   ├── AppDelegate.swift
    │   │   ├── GoogleService-Info.plist
    │   │   ├── Info.plist
    │   │   ├── Runner-Bridging-Header.h
    │   │   ├── Assets.xcassets/
    │   │   │   ├── AppIcon.appiconset/
    │   │   │   │   └── Contents.json
    │   │   │   └── LaunchImage.imageset/
    │   │   │       ├── README.md
    │   │   │       └── Contents.json
    │   │   └── Base.lproj/
    │   │       ├── LaunchScreen.storyboard
    │   │       └── Main.storyboard
    │   └── RunnerTests/
    │       └── RunnerTests.swift
    └── lib/
        ├── app.dart
        ├── main-prod.dart
        ├── main.dart
        ├── base/
        │   ├── base_bindings.dart
        │   ├── base_controller.dart
        │   ├── base_map_controller.dart
        │   ├── base_repository.dart
        │   ├── base_view.dart
        │   ├── language_controller.dart
        │   ├── map_mixin.dart
        │   ├── mixin_overlays.dart
        │   ├── swipable_refresh.dart
        │   ├── swipeable_controller.dart
        │   ├── view_mixin.dart
        │   └── dio/
        │       ├── dio_client.dart
        │       └── logger.dart
        ├── db/
        │   └── app_pref.dart
        ├── di/
        │   └── initial_bindings.dart
        ├── dialogs/
        │   ├── confirm_change_status.dart
        │   ├── confirmation_dialog.dart
        │   ├── succuess_dialog.dart
        │   └── config_server/
        │       ├── config_server_dialog_controller.dart
        │       └── config_srever_dialog.dart
        ├── environment/
        │   └── flavor_config.dart
        ├── extensions/
        │   ├── date_time_extention.dart
        │   ├── num_extention.dart
        │   └── string_extension.dart
        ├── helper/
        │   ├── auth_helper.dart
        │   ├── callback.dart
        │   └── flash_helper.dart
        ├── local/
        │   ├── ar_eg.dart
        │   ├── en_us.dart
        │   └── localization_service.dart
        ├── models/
        │   ├── local_enums.dart
        │   ├── map_layers.dart
        │   ├── map_styles.dart
        │   ├── on_boarding.dart
        │   ├── server_config.dart
        │   ├── server_health.dart
        │   ├── status.dart
        │   ├── unit.dart
        │   ├── user.dart
        │   ├── api/
        │   │   ├── api_response.dart
        │   │   ├── error_model.dart
        │   │   ├── page_properties.dart
        │   │   ├── pagination_data.dart
        │   │   └── resource.dart
        │   ├── args/
        │   │   ├── args_coming_soon.dart
        │   │   └── args_images_viewer.dart
        │   └── helper/
        │       ├── Language.dart
        │       └── title_model.dart
        ├── navigation/
        │   ├── app_pages.dart
        │   └── app_routes.dart
        ├── screens/
        │   ├── auth/
        │   │   ├── auth_bindings.dart
        │   │   ├── auth_controller.dart
        │   │   ├── auth_repository.dart
        │   │   ├── auth_screen.dart
        │   │   ├── register_unit/
        │   │   │   ├── register_unit_bindings.dart
        │   │   │   ├── register_unit_controller.dart
        │   │   │   ├── register_unit_repository.dart
        │   │   │   └── register_unit_screen.dart
        │   │   └── server_config/
        │   │       ├── server_config_bindings.dart
        │   │       ├── server_config_controller.dart
        │   │       ├── server_config_repository.dart
        │   │       └── server_config_screen.dart
        │   ├── coming_soon/
        │   │   └── coming_soon.dart
        │   ├── home/
        │   │   ├── home_bindings.dart
        │   │   ├── home_controller.dart
        │   │   ├── home_repository.dart
        │   │   ├── home_screen.dart
        │   │   ├── unit_danger/
        │   │   │   ├── danger_activation_dialog.dart
        │   │   │   ├── danger_cancellation_dialog.dart
        │   │   │   └── unit_danger_card.dart
        │   │   └── widgets/
        │   │       ├── bottom_card_info.dart
        │   │       ├── drawer_panel.dart
        │   │       ├── logout_dialog.dart
        │   │       ├── notification_panel.dart
        │   │       └── user_widget.dart
        │   ├── image_viewer/
        │   │   └── image_viewer.dart
        │   ├── my_unit/
        │   │   ├── my_unit_bindings.dart
        │   │   ├── my_unit_controller.dart
        │   │   ├── my_unit_repository.dart
        │   │   └── my_unit_screen.dart
        │   ├── onboarding/
        │   │   ├── onboarding_bindings.dart
        │   │   ├── onboarding_controller.dart
        │   │   └── onboarding_screen.dart
        │   ├── settings/
        │   │   ├── settings_bindings.dart
        │   │   ├── settings_controller.dart
        │   │   ├── settings_repository.dart
        │   │   └── settings_screen.dart
        │   └── splash/
        │       ├── splash_bindings.dart
        │       ├── splash_controller.dart
        │       ├── splash_repository.dart
        │       └── splash_screen.dart
        ├── sheets/
        │   ├── unit_info_sheet.dart
        │   ├── availability/
        │   │   ├── availability_sheet.dart
        │   │   ├── availability_sheet_controller.dart
        │   │   └── availability_sheet_repository.dart
        │   └── map_style/
        │       ├── map_style_controller.dart
        │       └── map_style_sheet.dart
        ├── theme/
        │   ├── app_animation.dart
        │   ├── app_colors.dart
        │   ├── app_icons.dart
        │   ├── app_images.dart
        │   ├── app_spacing.dart
        │   ├── app_themes.dart
        │   ├── grey_theme.dart
        │   └── theme_controller.dart
        ├── utils/
        │   ├── api_constatnts.dart
        │   ├── app_utils.dart
        │   ├── constants.dart
        │   ├── date_time_util.dart
        │   ├── device_utils.dart
        │   ├── image_util.dart
        │   ├── location_utils.dart
        │   ├── paths.dart
        │   ├── permissions_utils.dart
        │   └── validation.dart
        └── widgets/
            ├── animated_holder.dart
            ├── availablity_status.dart
            ├── base_text_field.dart
            ├── change_language_widget.dart
            ├── empty_item.dart
            ├── expansion_widget.dart
            ├── swipeable_list_view.dart
            ├── switch_widget.dart
            ├── avatar/
            │   ├── circular_avatar.dart
            │   └── rounded_avatar.dart
            ├── bin_code/
            │   └── flutter_pin_code_fields.dart
            ├── buttons/
            │   ├── base_text_button.dart
            │   └── loading_button.dart
            ├── dropdown/
            │   ├── drop_down.dart
            │   └── dropdown_controller.dart
            └── loaders/
                ├── loader.dart
                ├── loading_page.dart
                ├── widget_circular_loader.dart
                └── shimmer/
                    ├── chat_shimmer_loader.dart
                    ├── circular_shimmer_loader.dart
                    ├── grid_shimmer_loader.dart
                    ├── linear_shimmer_loader.dart
                    └── shimmer_list_loader.dart

