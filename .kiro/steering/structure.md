# Project Structure

## Root Directory Organization

```
qatar_al_nada/
├── lib/                    # Main Dart source code
├── assets/                 # Static assets (fonts, images, data)
├── android/               # Android-specific configuration
├── ios/                   # iOS-specific configuration
├── web/                   # Web-specific configuration
├── windows/               # Windows-specific configuration
├── macos/                 # macOS-specific configuration
├── linux/                 # Linux-specific configuration
├── test/                  # Unit and widget tests
├── .kiro/                 # Kiro AI assistant configuration
├── pubspec.yaml           # Project dependencies and metadata
└── README.md              # Project documentation
```

## Source Code Structure (`lib/`)

### Main Application Files
- **`main.dart`**: App entry point, MaterialApp setup, and main HomePage
- **`about_page.dart`**: About/info page with developer information

### Theme System (`lib/theme/`)
- **`airbnb_theme.dart`**: Complete design system implementation
  - Color palette (primary red, neutrals, accent colors)
  - Typography system (Google Fonts integration)
  - Component themes (buttons, cards, app bars)
  - Light/Dark/Sepia theme variants
  - Spacing and border radius constants
  - Animation durations and curves

### Custom Widgets (`lib/widgets/`)
- **`airbnb_widgets.dart`**: Reusable UI components
  - `AirbnbButton`: Animated button with loading states
  - `AirbnbCard`: Interactive card with hover effects
  - `AirbnbIconButton`: Circular icon button
  - `AirbnbShimmer`: Loading skeleton component
  - `AirbnbTabBar`: Animated tab navigation
  - `AirbnbFloatingMenu`: Expandable floating action menu

- **`airbnb_drawer.dart`**: Navigation drawer implementation
  - Font selection dropdown
  - Theme switching options
  - Navigation menu items
  - Animated list items

## Assets Organization (`assets/`)

### Data
- **`data.json`**: Main content file containing Arabic text chapters
  - Structured as array of objects with id, title, content
  - Arabic text with proper RTL formatting

### Fonts (`assets/fonts/`)
- **`Amiri.ttf`**: Classical Arabic font
- **`arabic.ttf`**: Standard Arabic font (Noto family)
- **`noorehira.ttf`**: Noor Arabic font variant

### Images (`assets/img/`)
- **`icon.png`**: App launcher icon
- **`head_drawer.png`**: Drawer header image

## Platform-Specific Configurations

### Android (`android/`)
- **`app/build.gradle.kts`**: Build configuration and dependencies
- **`app/src/main/AndroidManifest.xml`**: App permissions and metadata
- **`app/keystore.jks`**: Release signing keystore
- **`app/src/main/kotlin/`**: Native Android code (MainActivity)
- **`app/src/main/res/`**: Android resources (icons, styles)

### iOS (`ios/`)
- **`Runner.xcodeproj/`**: Xcode project configuration
- **`Runner/Info.plist`**: iOS app configuration
- **`Runner/Assets.xcassets/`**: iOS app icons and launch images
- **`Podfile`**: CocoaPods dependencies

### Web (`web/`)
- **`index.html`**: Web app entry point
- **`manifest.json`**: PWA configuration
- **`icons/`**: Web app icons for different sizes

## Code Organization Patterns

### File Naming Conventions
- **Snake case**: For file names (`airbnb_theme.dart`, `about_page.dart`)
- **Pascal case**: For class names (`AirbnbTheme`, `HomePage`)
- **Camel case**: For variables and methods (`currentFont`, `changeTheme()`)

### Widget Structure
- **Stateless widgets**: For static UI components
- **Stateful widgets**: For interactive components with local state
- **Provider pattern**: For app-wide state management
- **Composition over inheritance**: Prefer widget composition

### Import Organization
```dart
// Flutter framework imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Third-party package imports
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Local imports
import 'theme/airbnb_theme.dart';
import 'widgets/airbnb_widgets.dart';
```

## State Management Architecture

### App-Level State (`AppState` class)
- Current font selection
- Current theme selection
- Managed via Provider pattern
- Persisted locally for user preferences

### Page-Level State
- Current page index
- Loading states
- Animation controllers
- UI interaction states

### Component-Level State
- Button press states
- Hover effects
- Local animations
- Form inputs

## Content Management

### Data Structure
```json
{
  "id": number,
  "title": "Arabic title",
  "content": "Arabic content with proper formatting"
}
```

### Content Guidelines
- All Arabic text uses RTL direction
- Proper Unicode encoding for Arabic characters
- Structured content with clear hierarchy
- Educational focus with grammatical explanations

## Development Workflow

### Adding New Features
1. Create feature branch
2. Implement in appropriate directory structure
3. Follow existing naming conventions
4. Add to appropriate widget/theme files
5. Test across platforms
6. Update documentation

### Modifying Content
1. Edit `assets/data.json` for text changes
2. Update fonts in `assets/fonts/` if needed
3. Modify theme in `lib/theme/airbnb_theme.dart`
4. Test RTL layout and Arabic rendering

### Platform-Specific Changes
1. Android: Modify files in `android/` directory
2. iOS: Use Xcode to modify `ios/` configuration
3. Web: Update `web/` directory files
4. Desktop: Modify respective platform directories