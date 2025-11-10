# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Green Sense is a Flutter web application promoting environmental awareness with the tagline "Every green seed of awareness grows a brighter future". The app is deployed to Netlify and features a responsive, single-page design with sections for environmental education and community engagement.

## Quick Reference

**Most Common Commands:**
```bash
# Install dependencies
flutter pub get

# Run in development (requires Flutter installed locally)
flutter run -d chrome

# Run tests
flutter test

# Build for web (production)
flutter build web --release

# Analyze code
flutter analyze
```

**Key Dependencies:**
- `url_strategy` - URL routing for web
- `scroll_to_index` - Scroll to specific sections
- `font_awesome_flutter` - Icon library
- `url_launcher` - Launch URLs/emails

## Architecture

### Project Structure

```
lib/
├── main.dart                           # App entry point, MaterialApp setup
├── constants/                          # Shared constants
│   ├── app_colors.dart                # Color palette (green theme)
│   ├── app_styles.dart                # Text styles
│   └── info.dart                      # App metadata
├── screens/                           # Full-page screens
│   ├── home_screen.dart              # Main landing page (composition of widgets)
│   ├── about.dart                    # About page
│   ├── contact.dart                  # Contact page
│   └── introduction.dart             # Introduction page
├── widgets/                          # Reusable UI components
│   ├── home_app_bar.dart            # Top navigation bar
│   ├── hero_section.dart            # Hero/banner section
│   ├── personal_relevance_section.dart
│   ├── micro_action_section.dart
│   ├── community_pledge_section.dart
│   ├── footer.dart                  # Footer component
│   ├── header.dart                  # Generic header widget
│   ├── custom_text.dart             # Text component
│   ├── tab_title.dart               # Tab title utility
│   └── email_link.dart              # Email link widget
└── utilities/
    └── launch_url.dart              # URL launching utilities
```

### Design System

**Color Palette** (defined in `lib/constants/app_colors.dart`):
- Primary: `#10B981` (emerald green)
- Secondary: `#047857` (darker green)
- Accent: `#6EE7B7` (light green)
- Background: `#F0FDF4` (very light green)
- Text: `#1F2937` (dark gray)
- Heading: `#065F46` (forest green)

**Typography** (defined in `lib/constants/app_styles.dart`):
- headline1: 48px bold (headings)
- headline2: 36px bold (subheadings)
- subtitle: 20px (subtitles)
- bodyText: 16px (body content)
- button: 18px bold (buttons)

### Component Architecture

The app follows a **composition pattern**:
- `HomeScreen` composes multiple section widgets vertically in a `SingleChildScrollView`
- Each section is a separate widget (`HeroSection`, `PersonalRelevanceSection`, etc.)
- Widgets are stateless and self-contained
- Shared styling comes from `AppColors` and `AppStyles` constants

**Example Pattern:**
```dart
// Typical widget structure
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(...),
      child: Column(
        children: [
          Text('Title', style: AppStyles.headline1),
          // More content...
        ],
      ),
    );
  }
}
```

## Development Workflow

### Setting Up Development Environment

1. **Install Flutter SDK**
   ```bash
   # Follow official instructions at https://flutter.dev/docs/get-started/install
   ```

2. **Clone and Setup**
   ```bash
   git clone <repository-url>
   cd green_sense
   flutter pub get
   ```

3. **Run Development Server**
   ```bash
   # For web development
   flutter run -d chrome

   # With hot reload enabled automatically
   # Changes in lib/ will auto-refresh
   ```

### Testing

The project has minimal test coverage currently:
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test
flutter test test/widget_test.dart
```

**Note:** The default widget test is a boilerplate that doesn't match the actual app structure and will fail. Tests should be updated to match the actual widget tree.

### Code Quality

```bash
# Analyze code (finds potential issues)
flutter analyze

# Format code
flutter format lib/ test/

# Check for outdated packages
flutter pub outdated
```

### Building for Production

```bash
# Build web release
flutter build web --release

# Output will be in build/web/
# This is what Netlify deploys
```

## Deployment

### Netlify Configuration

The app auto-deploys to Netlify using the configuration in `netlify.toml`:
- Build command: `flutter build web --release`
- Publish directory: `build/web`
- Plugin: `netlify-plugin-flutter` (stable channel)

**Deployment triggers:**
- Automatic on push to main branch
- Manual deploys via Netlify UI

## Important Patterns

### Adding a New Section Widget

1. Create widget file in `lib/widgets/`:
   ```dart
   import 'package:flutter/material.dart';
   import 'package:green_sense/constants/app_colors.dart';
   import 'package:green_sense/constants/app_styles.dart';

   class NewSection extends StatelessWidget {
     const NewSection({super.key});

     @override
     Widget build(BuildContext context) {
       return Container(
         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
         child: // Your content
       );
     }
   }
   ```

2. Add to `HomeScreen` in `lib/screens/home_screen.dart`:
   ```dart
   Column(
     children: [
       HeroSection(),
       SizedBox(height: 20),
       NewSection(), // Add here
       // Other sections...
     ],
   )
   ```

### Using Consistent Styling

**Always use constants from `app_colors.dart` and `app_styles.dart`:**
```dart
// Good
Text('Title', style: AppStyles.headline1)
Container(color: AppColors.primaryColor)

// Bad - avoid inline styles
Text('Title', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold))
Container(color: Color(0xFF10B981))
```

### Adding Icons

The app uses both Material icons (built-in) and Font Awesome:
```dart
// Material icons (always available)
Icon(Icons.eco, color: AppColors.primaryColor)

// Font Awesome (import required)
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
FaIcon(FontAwesomeIcons.leaf, color: AppColors.primaryColor)
```

### Responsive Design

The app should work on various screen sizes:
```dart
// Use constraints for max width
Container(
  constraints: const BoxConstraints(maxWidth: 1200),
  child: // Content
)

// Use MediaQuery for responsive sizing
final screenWidth = MediaQuery.of(context).size.width;
final isMobile = screenWidth < 600;
```

## Common Tasks

### Updating the Color Scheme

Edit `lib/constants/app_colors.dart`:
```dart
class AppColors {
  static const Color primaryColor = Color(0xFF10B981); // Change here
  // All components will auto-update
}
```

### Adding a New Page/Screen

1. Create screen in `lib/screens/new_screen.dart`
2. Add navigation logic (currently app is single-page, navigation not implemented)
3. If adding routing, you'll need to configure routing in `main.dart`

### Updating Text Styles

Edit `lib/constants/app_styles.dart`:
```dart
static const TextStyle headline1 = TextStyle(
  fontSize: 48,  // Adjust here
  fontWeight: FontWeight.bold,
  color: AppColors.headingColor,
);
```

## Important Notes

- **Stateless Widgets**: The entire app uses stateless widgets. If you need state management, consider adding `provider`, `bloc`, or `riverpod` to `pubspec.yaml`
- **Web-First**: This is primarily a web application. While it has Android/iOS/Windows/macOS/Linux folders, the focus is on web deployment
- **No Routing**: The app is currently a single-page application. Navigation between "screens" is not implemented
- **No Backend**: This is a static frontend application with no backend integration
- **Asset Management**: Images go in the `images/` folder and must be declared in `pubspec.yaml` under `assets:`

## Dependencies Management

When adding a new package:
```bash
# Add to pubspec.yaml, then:
flutter pub get

# Or use the command:
flutter pub add package_name
```

**Current key dependencies:**
- `url_strategy: ^0.2.0` - Enables clean URLs for web (no # in URL)
- `scroll_to_index: ^3.0.1` - Programmatic scrolling to sections
- `font_awesome_flutter: ^10.7.0` - Additional icon set
- `url_launcher: ^6.3.0` - Opens URLs and emails

## Troubleshooting

**Build fails:**
```bash
flutter clean
flutter pub get
flutter build web --release
```

**Hot reload not working:**
- Save the file explicitly
- Try `r` in terminal to hot reload manually
- Try `R` for hot restart

**Tests failing:**
- The default test in `test/widget_test.dart` is boilerplate and doesn't match the app
- Update tests to match actual widget structure

**Netlify build fails:**
- Check that `netlify.toml` is correctly configured
- Ensure all dependencies in `pubspec.yaml` are compatible with stable Flutter channel
- Check Netlify build logs for specific Flutter errors
