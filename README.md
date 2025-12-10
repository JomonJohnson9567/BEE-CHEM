# 🐝 Bee Chem - Personnel Management System

A modern, feature-rich Flutter application for managing personnel details with a beautiful UI and robust architecture. Built with clean architecture principles, BLoC state management, and seamless API integration.

![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-Private-red)

## 📱 Features

### 🔐 Authentication
- **Secure Login System** with email and password validation
- **Remember Me** functionality for persistent sessions
- **Auto-login** support for returning users
- **Session Management** with secure token storage
- Beautiful honeycomb-themed login UI

### 👥 Personnel Management
- **View Personnel List** with real-time status indicators (Active/Inactive)
- **Add New Personnel** with comprehensive form validation
- **Detailed Personnel View** via interactive popup dialogs
- **Role-based Organization** with dynamic role selection
- **Smart UI** with text truncation for long names
- **Shimmer Loading** effects for enhanced UX

### 🎨 User Interface
- Modern, clean design with custom color scheme
- Responsive layouts that work across all device sizes
- Smooth animations and transitions
- Custom widgets for consistent UI patterns
- Sticky headers and action buttons for better usability
- Glass-morphism effects and premium aesthetics

### 🏗️ Architecture Highlights
- **Clean Architecture** with clear separation of concerns
- **BLoC Pattern** for predictable state management
- **Repository Pattern** for data abstraction
- **Stateless Widgets** wherever possible for better performance
- **Form Validation** with real-time error feedback
- **Error Handling** with user-friendly messages

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.9.2 or higher)
- [Dart SDK](https://dart.dev/get-dart) (3.9.2 or higher)
- An IDE (VS Code, Android Studio, or IntelliJ IDEA)
- Android Studio / Xcode for mobile emulators

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter_machine_task
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 📦 Dependencies

### Core Dependencies
- **flutter_bloc** (^9.0.0) - State management
- **equatable** (^2.0.5) - Value equality
- **http** (^1.2.2) - HTTP requests
- **shared_preferences** (^2.3.2) - Local data persistence
- **shimmer** (^3.0.0) - Loading animations
- **rxdart** (^0.28.0) - Reactive programming utilities

### Dev Dependencies
- **flutter_test** - Testing framework
- **flutter_lints** (^5.0.0) - Code quality and linting

## 🏛️ Project Structure

```
lib/
├── core/
│   └── constants/
│       └── app_colors.dart          # App-wide color definitions
├── data/
│   ├── models/                      # Data models
│   │   ├── personnel_model.dart
│   │   ├── role_model.dart
│   │   ├── login_request.dart
│   │   ├── login_response.dart
│   │   └── add_personnel_request.dart
│   ├── repository/                  # Data repositories
│   │   ├── auth_repository.dart
│   │   └── personnel_repository.dart
│   └── services/                    # API services
│       └── api_service.dart
├── presentation/
│   ├── bloc/                        # BLoC state management
│   │   ├── bootstrap/
│   │   ├── login/
│   │   ├── logout/
│   │   ├── personnel_list/
│   │   └── add_personnel/
│   └── screens/                     # UI screens
│       ├── splash/
│       ├── login_page/
│       ├── personal details/
│       └── add_personal details/
└── main.dart                        # App entry point
```

## 🔧 Configuration

### API Configuration

The app connects to the Bee Chem API. The base URL is configured in:
- `lib/data/repository/auth_repository.dart`
- `lib/data/services/api_service.dart`

```dart
static const _baseUrl = 'https://beechem.ishtech.live/api';
```

### Shared Preferences Keys

The app uses the following keys for local storage:
- `auth_token` - Authentication token
- `current_user_email` - Current logged-in user email
- `remembered_email` - Saved email for remember me
- `remembered_password` - Saved password for remember me
- `remember_me_enabled` - Remember me flag

## 🎯 Key Features Explained

### BLoC State Management

The app uses the BLoC pattern for all state management:

```dart
// Example: Login BLoC
BlocProvider(
  create: (context) => LoginBloc(
    authRepository: RepositoryProvider.of<AuthRepository>(context),
  )..add(const LoginStarted()),
  child: const LoginView(),
)
```

### Form Validation

Real-time form validation with error display:
- Email format validation
- Password strength requirements
- Required field validation
- Custom error messages per field

### Personnel Details

Each personnel entry includes:
- First Name & Last Name
- Complete Address (Address, Suburb, State, Postcode, Country)
- Contact Number
- Geographic Coordinates (Latitude, Longitude)
- Role Assignment
- Active/Inactive Status

## 🧪 Testing

Run tests with:

```bash
flutter test
```

## 🎨 UI/UX Features

- **Honeycomb Header** - Custom branded login screen
- **Shimmer Effects** - Elegant loading states
- **Sticky Elements** - Headers and buttons stay visible while scrolling
- **Text Truncation** - Prevents UI overflow with long names
- **Dialog Popups** - View full personnel details
- **Responsive Design** - Works on phones, tablets, and web

## 🔒 Security

- Secure token-based authentication
- Password encryption (handled by backend)
- Session management with auto-logout
- Secure credential storage using SharedPreferences
- HTTPS API communication

## 🐛 Known Issues & Limitations

- Currently supports single-user sessions
- No offline mode (requires internet connection)
- Limited to predefined roles from API

## 🚧 Future Enhancements

- [ ] Offline support with local database
- [ ] Personnel search and filtering
- [ ] Edit personnel details
- [ ] Delete personnel functionality
- [ ] Profile picture upload
- [ ] Export personnel data (PDF/CSV)
- [ ] Multi-language support
- [ ] Dark mode theme
- [ ] Push notifications

## 👨‍💻 Development

### Code Style

This project follows the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style) and uses `flutter_lints` for code quality.

### Git Workflow

1. Create a feature branch from `main`
2. Make your changes
3. Run tests and linting
4. Submit a pull request

## 📄 License

This project is private and not licensed for public use.

## 🤝 Contributing

This is a private project. For contribution guidelines, please contact the project maintainer.

## 📞 Support

For issues, questions, or support:
- Create an issue in the repository
- Contact the development team

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- BLoC library maintainers
- Bee Chem team for API support

---

**Built with ❤️ using Flutter**
