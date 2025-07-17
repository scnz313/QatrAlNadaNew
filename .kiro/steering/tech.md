# Technology Stack

## Framework & Platform
- **Flutter 3.0+**: Cross-platform mobile/desktop/web framework
- **Dart SDK**: >=3.0.0 <4.0.0
- **Target Platforms**: Android, iOS, Web, Windows, macOS, Linux

## Key Dependencies

### UI & Design System
- **flutter_animate**: ^4.5.0 - Smooth animations and micro-interactions
- **flutter_staggered_animations**: ^1.1.1 - List and grid animations
- **shimmer**: ^3.0.0 - Loading skeleton effects
- **google_fonts**: ^6.2.1 - Typography system
- **flutter_screenutil**: ^5.9.3 - Responsive design
- **card_swiper**: ^3.0.1 - Swipeable content navigation
- **smooth_page_indicator**: ^1.2.0 - Page indicators
- **flutter_svg**: ^2.0.10 - Vector graphics support

### State Management
- **provider**: ^6.1.2 - Simple state management for theme/font preferences

### Data & Storage
- **sqflite**: ^2.3.2 - Local SQLite database
- **path_provider**: ^2.1.2 - File system paths
- **cached_network_image**: ^3.4.0 - Image caching

### Utilities
- **url_launcher**: ^6.3.0 - External URL handling
- **font_awesome_flutter**: ^10.8.0 - Icon library
- **cupertino_icons**: ^1.0.8 - iOS-style icons

### Development Tools
- **flutter_launcher_icons**: ^0.13.1 - App icon generation
- **flutter_lints**: ^2.0.2 - Code quality rules

## Architecture Patterns

### Design System
- **Airbnb-inspired UI**: Custom theme system with consistent colors, typography, and spacing
- **Component-based**: Reusable widgets (AirbnbButton, AirbnbCard, AirbnbDrawer)
- **Theme Support**: Light, Dark, Sepia themes with automatic switching
- **RTL Support**: Full right-to-left layout support for Arabic content

### State Management
- **Provider Pattern**: Simple state management for app-wide settings
- **Local State**: StatefulWidget for component-specific state
- **Persistent Settings**: Font and theme preferences stored locally

### Data Architecture
- **JSON-based Content**: Static content stored in assets/data.json
- **Local Database**: SQLite for potential future features
- **Asset Management**: Fonts and images organized in assets/ directory

## Common Commands

### Development
```bash
# Get dependencies
flutter pub get

# Run on connected device/emulator
flutter run

# Run on specific platform
flutter run -d chrome          # Web
flutter run -d macos           # macOS
flutter run -d windows         # Windows

# Hot reload during development
# Press 'r' in terminal or use IDE hot reload
```

### Building
```bash
# Build APK for Android
flutter build apk --release

# Build iOS (requires macOS and Xcode)
flutter build ios --release

# Build for web
flutter build web --release

# Build for desktop platforms
flutter build macos --release
flutter build windows --release
flutter build linux --release
```

### Code Quality
```bash
# Run linter
flutter analyze

# Format code
flutter format .

# Run tests
flutter test
```

### Asset Management
```bash
# Generate app icons (after updating assets/img/icon.png)
flutter pub run flutter_launcher_icons:main

# Clean build cache
flutter clean
flutter pub get
```

## Build Configuration

### Android
- **Minimum SDK**: API level 21 (Android 5.0)
- **Target SDK**: Latest stable
- **Signing**: Uses keystore.jks for release builds
- **Permissions**: Internet access for potential future features

### iOS
- **Minimum Version**: iOS 11.0
- **Deployment Target**: Universal (iPhone/iPad)
- **Signing**: Automatic signing configured

### Web
- **Renderer**: HTML renderer for better text rendering (important for Arabic)
- **Base href**: Configurable for deployment

## Performance Considerations
- **Lazy Loading**: Content loaded as needed
- **Image Optimization**: Cached network images
- **Animation Performance**: Hardware acceleration enabled
- **Memory Management**: Proper disposal of controllers and listeners
- **Arabic Text Rendering**: Optimized fonts and text direction handling