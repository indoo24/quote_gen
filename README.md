# Daily Quote App

A clean, modern Flutter application that delivers daily inspirational quotes to users. Built with Clean Architecture principles and leveraging AI-assisted development tools to demonstrate best practices in mobile application development and modern development workflows.

## Overview

Daily Quote App is a mobile application that fetches random motivational quotes from a public API, allowing users to discover new inspiration daily. The application emphasizes clean code, scalable architecture, and a polished user experience. This project was developed as part of an AI tool proficiency assignment, showcasing effective collaboration between human expertise and AI assistance.

## Features

- **Daily Random Quote**: Fetch a new inspirational quote on demand from a public API
- **Favorites Management**: Mark quotes as favorites and persist selections locally
- **Favorites Library**: View and manage all saved favorite quotes in a dedicated screen
- **Quote Sharing**: Share quotes with others via native share functionality
- **Error Handling**: Graceful error states with user-friendly messages and retry options
- **Loading States**: Smooth loading indicators for better user experience
- **Material 3 Design**: Modern, polished UI following Material Design 3 guidelines
- **Responsive UI**: Clean, centered layouts optimized for various screen sizes

## Tech Stack

- **Framework**: Flutter 3.9
- **Language**: Dart
- **State Management**: Provider (ChangeNotifier pattern)
- **HTTP Client**: http package for API communication
- **Sharing**: share_plus for cross-platform sharing
- **UI**: Material 3 design system
- **API**: Quotable.io public quotes API

## Architecture

This project implements **Clean Architecture** to ensure separation of concerns, testability, and maintainability. The codebase is organized into three distinct layers:

### Domain Layer
- **Responsibility**: Core business logic and entities
- **Contains**: Entity definitions (Quote), repository interfaces
- **Dependencies**: None (pure Dart, framework-agnostic)
- **Purpose**: Defines the business rules independent of frameworks or external systems

### Data Layer
- **Responsibility**: Data sources and repository implementations
- **Contains**: Data models, repository implementations (API, mock)
- **Dependencies**: Domain layer interfaces
- **Purpose**: Handles data retrieval from external sources (API, local storage)

### Presentation Layer
- **Responsibility**: UI and user interaction
- **Contains**: Screens, widgets, state management (Providers)
- **Dependencies**: Domain layer entities and repository interfaces
- **Purpose**: Presents data to users and handles user input

This architectural approach ensures that business logic remains isolated from UI and data concerns, making the codebase more testable, maintainable, and scalable.

## AI Tooling & Workflow

This project demonstrates effective use of AI-assisted development tools throughout the entire development lifecycle. The development process integrated multiple AI tools while maintaining human oversight and code quality standards.

### AI Tools Used

- **ChatGPT / Claude**: Architecture planning, code structure design, and implementation guidance
- **GitHub Copilot**: Code completion, boilerplate generation, and inline suggestions
- **Cursor / AI IDEs**: Contextual code generation and refactoring assistance
- **AI Design Tools**: Initial UI mockups and design system generation

### AI-Assisted Workflow

**Architecture Scaffolding**
- Used AI to generate initial Clean Architecture folder structure
- Generated boilerplate for repository interfaces and entity definitions
- Created provider templates following best practices

**Code Implementation**
- Leveraged AI for repetitive code patterns (models, widgets)
- Generated widget boilerplate with proper state management integration
- Automated creation of common UI components (buttons, cards, navigation)

**UI Generation**
- Used AI design tools to create initial UI concepts and layouts
- Generated Material 3 theme configurations with consistent color schemes
- Created reusable widget templates for quote cards and action buttons

**Debugging & Refinement**
- Utilized AI for error diagnosis and resolution suggestions
- Iteratively refined code with AI-assisted refactoring
- Improved code documentation through AI-generated comments

**Human Oversight**
- All AI-generated code was reviewed and validated for correctness
- Architecture decisions were human-driven with AI as a consultation tool
- Code was iteratively refined based on testing and real-world usage
- Final implementation reflects human judgment and quality standards

The combination of AI efficiency and human expertise resulted in faster development cycles while maintaining high code quality and architectural integrity.

## Design

The application features a clean, modern interface built with Material 3 design principles. The UI was initially prototyped using AI design tools and iteratively refined based on user experience considerations.

**Design Highlights:**
- Minimalist quote cards with elegant typography
- Consistent color scheme following Material 3 guidelines
- Intuitive bottom navigation with clear iconography
- Smooth transitions and loading states
- Accessible contrast ratios and touch targets

> **Note**: Screenshots and design assets will be added to the `/screenshots` directory upon final submission.

## Getting Started

### Prerequisites

- Flutter SDK 3.9.2 or higher
- Dart SDK 3.9.2 or higher
- Android Studio / VS Code with Flutter extensions
- iOS development tools (for iOS deployment)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/indoo24/quote_gen.git
cd quote_gen
```

2. Install dependencies:
```bash
flutter pub get
```

3. Verify Flutter installation:
```bash
flutter doctor
```

### Running the App

**Development Mode:**
```bash
flutter run
```

**Build for Release:**
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

**Run Tests:**
```bash
flutter test
```

## Error Handling

The application implements robust error handling to ensure a smooth user experience even when network or API issues occur.

### Network Error Handling
- Catches HTTP exceptions and connection timeouts
- Displays user-friendly error messages instead of technical stack traces
- Provides visual feedback when errors occur

### Retry Mechanism
- Refresh button allows users to retry failed quote fetches
- State is properly reset between retry attempts
- Loading indicators prevent multiple simultaneous requests

### Graceful Degradation
- Application remains functional even if API is unavailable
- Favorites functionality works offline using local persistence
- Error states are clearly communicated without disrupting user flow

## Project Structure

```
lib/
├── core/
│   └── theme/
│       └── app_theme.dart          # Material 3 theme configuration
├── data/
│   ├── models/
│   │   └── quote_model.dart        # Quote data model with JSON serialization
│   └── repositories/
│       ├── api_quote_repository.dart   # API implementation
│       └── mock_quote_repository.dart  # Mock implementation for testing
├── domain/
│   ├── entities/
│   │   └── quote.dart              # Quote entity (business object)
│   └── repositories/
│       └── quote_repository.dart   # Repository interface
├── presentation/
│   ├── providers/
│   │   └── quote_provider.dart     # State management (ChangeNotifier)
│   ├── screens/
│   │   ├── home/
│   │   │   └── home_screen.dart    # Daily quote screen
│   │   ├── favorites/
│   │   │   └── favorites_screen.dart   # Favorites library screen
│   │   └── main_navigation_screen.dart # Bottom navigation container
│   └── widgets/
│       └── common/                 # Reusable UI components
└── main.dart                       # Application entry point
```

## Future Improvements

While the current implementation is functional and polished, several enhancements could further improve the application:

### Technical Enhancements
- **API Caching**: Implement caching layer to reduce network calls and improve performance
- **Local Database**: Add SQLite or Hive for persistent local storage of quotes and favorites
- **Offline Support**: Enable full offline functionality with cached quotes
- **Unit & Widget Tests**: Expand test coverage to ensure code reliability

### Feature Additions
- **Daily Notifications**: Push notifications with a new quote each morning
- **Categories**: Filter quotes by category (motivation, success, love, etc.)
- **Search**: Search functionality within favorites
- **Quote History**: Track previously viewed quotes
- **Custom Theming**: Light/dark mode toggle and customizable color themes
- **Social Features**: Community-curated collections and quote recommendations

### UX Improvements
- **Animations**: Add subtle animations for screen transitions and card interactions
- **Gestures**: Swipe gestures for navigation and quick actions
- **Accessibility**: Enhanced screen reader support and customizable font sizes
- **Onboarding**: Tutorial flow for first-time users

## License

This project is developed as a take-home assignment and is intended for educational and demonstration purposes.

## Acknowledgments

- Quotes provided by [Quotable.io](https://quotable.io) API
- Material Design guidelines by Google
- Flutter framework and community
- AI development tools that accelerated the development process

---

**Developed by**: indoo24  
**Repository**: [github.com/indoo24/quote_gen](https://github.com/indoo24/quote_gen)  
**Date**: January 2026
