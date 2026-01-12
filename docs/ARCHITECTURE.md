# Quote Generator - Flutter Application

A beautiful motivational quote application built with Flutter following Clean Architecture principles.

## 📱 Features

- Daily inspirational quotes
- Favorite/unfavorite quotes
- Share quotes with others
- Refresh to get new random quotes
- Beautiful Material 3 design
- Simple 2-tab navigation (Home, Favorites)

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                           # Core utilities and configurations
│   └── theme/
│       └── app_theme.dart         # Theme configuration (colors, text styles, etc.)
│
├── data/                          # Data layer
│   ├── models/
│   │   └── quote_model.dart      # Quote data model
│   └── repositories/
│       └── mock_quote_repository.dart  # Mock implementation of quote repository
│
├── domain/                        # Domain/Business layer
│   ├── entities/
│   │   └── quote.dart            # Quote entity (pure Dart, no dependencies)
│   └── repositories/
│       └── quote_repository.dart # Repository interface/contract
│
├── presentation/                  # Presentation layer
│   ├── providers/
│   │   └── quote_provider.dart   # State management (ChangeNotifier)
│   ├── screens/
│   │   ├── home/
│   │   │   └── home_screen.dart  # Home screen with daily quote
│   │   ├── favorites/
│   │   │   └── favorites_screen.dart  # Favorites collection screen
│   │   └── main_navigation_screen.dart  # Bottom navigation container
│   └── widgets/
│       └── common/
│           ├── quote_card.dart   # Reusable quote card widget
│           ├── action_button.dart  # Reusable action button widget
│           └── custom_bottom_nav_bar.dart  # Bottom navigation bar
│
└── main.dart                      # App entry point
```

## 📂 Layer Responsibilities

### Core Layer
- **Purpose**: Shared utilities, constants, and configurations
- **Contains**: Theme, colors, text styles, constants
- **Dependencies**: None (independent)

### Domain Layer
- **Purpose**: Business logic and entities
- **Contains**: Entities (Quote), Repository interfaces
- **Dependencies**: None (pure Dart, framework-independent)
- **Rules**: No Flutter or external package imports

### Data Layer
- **Purpose**: Data sources and repository implementations
- **Contains**: Models, Repository implementations (Mock, API, Database)
- **Dependencies**: Domain layer
- **Current Implementation**: MockQuoteRepository with hardcoded quotes

### Presentation Layer
- **Purpose**: UI and state management
- **Contains**: Screens, Widgets, Providers (ViewModels)
- **Dependencies**: Domain layer (entities, repositories)
- **State Management**: Provider (ChangeNotifier)

## 🎨 UI Components

### Screens
1. **HomeScreen**: Displays daily quote with favorite, refresh, and share actions
2. **FavoritesScreen**: Shows collection of favorited quotes
3. **MainNavigationScreen**: Container with bottom navigation (Home, Library, Daily, Settings)

### Reusable Widgets
1. **QuoteCard**: Beautiful card displaying quote text and author
2. **ActionButton**: Circular button with icon and label
3. **CustomBottomNavBar**: Bottom navigation bar with 4 tabs

## 🔧 State Management

**Provider Pattern** with ChangeNotifier:

- `QuoteProvider`: Manages quote state including:
  - Current daily quote
  - List of favorite quotes
  - Loading states
  - Error handling
  - Actions: load, refresh, toggle favorite, share

## 🎯 SOLID Principles Applied

1. **Single Responsibility**: Each class has one clear purpose
2. **Open/Closed**: Easy to extend (e.g., add new repository implementations)
3. **Liskov Substitution**: Repository interface allows swapping implementations
4. **Interface Segregation**: Small, focused interfaces
5. **Dependency Inversion**: High-level modules depend on abstractions (interfaces)

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  provider: ^6.1.2          # State management
  share_plus: ^10.1.4       # Share functionality
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.9.2 or higher)
- Dart SDK (3.9.2 or higher)

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## 🧪 Testing

Run tests:
```bash
flutter test
```

## 📝 Code Style

- Follow Flutter/Dart style guide
- Use `const` constructors wherever possible
- Meaningful variable and function names
- Comments explaining responsibilities
- Format code: `flutter format .`

## 🔮 Future Enhancements

### Data Layer
- [ ] Implement API integration (quotes API)
- [ ] Add local database (Hive/SQLite) for offline support
- [ ] Implement caching strategy

### Features
- [ ] Categories/topics for quotes
- [ ] Search functionality
- [ ] Notifications for daily quotes
- [ ] Custom quote backgrounds
- [ ] User-created quotes
- [ ] Social sharing with images

### UI/UX
- [ ] Dark theme support
- [ ] Animations and transitions
- [ ] Onboarding flow
- [ ] Settings screen (theme, notifications, etc.)

## 📄 License

This project is for educational purposes.

## 👨‍💻 Development Notes

### Current State
- ✅ Clean Architecture implemented
- ✅ Material 3 design
- ✅ Mock data (no API yet)
- ✅ Basic state management with Provider
- ✅ Responsive UI
- ✅ No business logic in widgets
- ✅ Reusable components

### Architecture Benefits
1. **Testability**: Each layer can be tested independently
2. **Maintainability**: Clear separation makes changes easier
3. **Scalability**: Easy to add new features
4. **Flexibility**: Can swap implementations (e.g., change data source)
5. **Team Collaboration**: Clear boundaries for different team members

---

**Built with ❤️ using Flutter and Clean Architecture**
