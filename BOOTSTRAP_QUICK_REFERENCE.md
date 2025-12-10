# AppBootstrapper - Quick Reference Guide

## 📁 File Locations

### BLoC Layer (Business Logic)
```
lib/logic/bootstrap/
├── bootstrap_event.dart   # Events that trigger state changes
├── bootstrap_state.dart   # States representing app bootstrap status
└── bootstrap_bloc.dart    # Business logic handling authentication check
```

### Presentation Layer (UI)
```
lib/presentation/screens/splash/
└── app_bootstrapper.dart  # Stateless widget for app initialization
```

## 🔄 State Flow

```
User Opens App
    ↓
AppBootstrapper created
    ↓
BootstrapBloc provided
    ↓
BootstrapCheckAuthStatus event added
    ↓
BLoC checks authentication (via AuthRepository)
    ↓
BLoC emits state:
    ├─ checking (loading)
    ├─ authenticated (go to PersonnelListScreen)
    └─ unauthenticated (go to LoginScreen)
    ↓
UI rebuilds based on state
```

## 📝 Code Snippets

### Adding Bootstrap Event
```dart
// Automatically triggered when AppBootstrapper is created
BootstrapBloc(authRepository: context.read<AuthRepository>())
  ..add(const BootstrapCheckAuthStatus())
```

### Listening to Bootstrap State
```dart
BlocBuilder<BootstrapBloc, BootstrapState>(
  builder: (context, state) {
    if (state.isChecking) {
      return LoadingScreen();
    }
    if (state.isAuthenticated) {
      return MainApp();
    }
    return LoginScreen();
  },
)
```

### Testing Bootstrap BLoC
```dart
test('should emit authenticated when user has valid session', () {
  // Arrange
  when(mockAuthRepo.shouldAutoLogin()).thenAnswer((_) async => true);
  final bloc = BootstrapBloc(authRepository: mockAuthRepo);
  
  // Act
  bloc.add(const BootstrapCheckAuthStatus());
  
  // Assert
  expect(
    bloc.stream,
    emitsInOrder([
      BootstrapState(status: BootstrapStatus.checking),
      BootstrapState(status: BootstrapStatus.authenticated),
    ]),
  );
});
```

## 🎯 Key Principles Applied

### 1. Single Responsibility
- **AppBootstrapper**: Only provides BLoC and delegates to view
- **_AppBootstrapperView**: Only renders UI based on state
- **BootstrapBloc**: Only handles authentication check logic
- **AuthRepository**: Only manages authentication data

### 2. Stateless Widgets
- No `StatefulWidget` used
- All state managed by BLoC
- Widgets are pure functions of state

### 3. Dependency Injection
- `AuthRepository` injected into `BootstrapBloc`
- Easy to mock for testing
- Loose coupling between layers

### 4. Immutability
- States are immutable
- Use `copyWith()` for state updates
- Predictable state changes

### 5. Separation of Concerns
- **Presentation**: What to show
- **Business Logic**: When to show it
- **Data**: Where to get the data

## 🔍 State Definitions

### BootstrapStatus Enum
```dart
enum BootstrapStatus {
  checking,        // Initial state, loading
  authenticated,   // User has valid session
  unauthenticated, // User needs to log in
}
```

### BootstrapState Class
```dart
class BootstrapState {
  final BootstrapStatus status;
  
  // Convenience getters
  bool get isChecking => status == BootstrapStatus.checking;
  bool get isAuthenticated => status == BootstrapStatus.authenticated;
  bool get isUnauthenticated => status == BootstrapStatus.unauthenticated;
}
```

## 🚀 Benefits

✅ **Testable**: Easy to unit test BLoC logic
✅ **Maintainable**: Clear separation of concerns
✅ **Scalable**: Easy to add new bootstrap logic
✅ **Consistent**: Follows project patterns
✅ **Type-Safe**: Compile-time checks for states
✅ **Debuggable**: Clear event → state flow

## 🛠️ Common Tasks

### Adding New Bootstrap Logic
1. Add new event in `bootstrap_event.dart`
2. Add handler in `bootstrap_bloc.dart`
3. Update state if needed in `bootstrap_state.dart`
4. UI automatically updates via `BlocBuilder`

### Debugging Bootstrap Issues
1. Check BLoC logs for event/state emissions
2. Verify `AuthRepository.shouldAutoLogin()` returns correct value
3. Ensure `BlocProvider` is above `BlocBuilder` in widget tree
4. Check for errors in BLoC event handler

### Extending Bootstrap State
```dart
// Example: Adding app version check
class BootstrapState {
  final BootstrapStatus status;
  final String? appVersion;  // New field
  final bool needsUpdate;    // New field
  
  // Update copyWith and constructor
}
```

## 📚 Related Files

- `lib/logic/login/login_bloc.dart` - Similar BLoC pattern
- `lib/logic/add_personnel/add_personnel_bloc.dart` - Similar pattern
- `lib/data/repository/auth_repository.dart` - Data layer
- `lib/main.dart` - App entry point using AppBootstrapper

## 🎓 Learning Resources

- [BLoC Pattern Documentation](https://bloclibrary.dev)
- [Clean Architecture in Flutter](https://resocoder.com/flutter-clean-architecture)
- [Flutter State Management](https://flutter.dev/docs/development/data-and-backend/state-mgmt)
