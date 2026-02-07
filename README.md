# 🕌 Iman - Islamic Companion App

A modern, production-grade Flutter application for Muslims, featuring Quran reading, prayer times, digital tasbih, hadith collection, and the 99 Names of Allah. Built with clean architecture and Riverpod state management.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)
![Riverpod](https://img.shields.io/badge/Riverpod-2.4+-blue)
![License](https://img.shields.io/badge/License-MIT-green)

---

## ✨ Features

### 📖 Quran Reader
- Complete Quran with 114 surahs
- Search functionality (Arabic, English, Bangla)
- Bookmark system to resume reading
- Revelation type indicators (Meccan/Medinan)
- Beautiful card-based UI

### ⏰ Prayer Times
- Automatic daily prayer schedule
- Real-time API integration (Muslim World League)
- Location-based calculations
- Current prayer highlighting with countdown
- Elegant time display cards

### 📿 Digital Tasbih
- Customizable dhikr counter
- Add/edit/delete dhikr
- Individual counters for each dhikr
- Circular counter UI with haptic feedback
- Persistent count tracking

### 📚 Hadith Collection
- Sahih Bukhari complete collection
- Multi-language support (Arabic, English, Bangla)
- Section-based browsing
- Easy language switching
- Clean, readable format

### ⭐ 99 Names of Allah
- All 99 beautiful names with meanings
- Search functionality
- Detailed view with translations
- Arabic, English, and Bangla meanings

### 🏠 Modern Home Screen
- Beautiful green gradient theme
- Quick-access Quran bookmark card
- Feature cards with descriptions
- Scrollable, responsive design
- Islamic-themed UI elements

---

## 🏗️ Architecture

This app follows **Pragmatic Clean Architecture** with **Riverpod** for state management.

### Project Structure
```
lib/
├── core/                          # Shared infrastructure
│   ├── constants/                 # App constants, API URLs, storage keys
│   ├── theme/                     # Colors, text styles, app theme
│   ├── utils/                     # Result<T>, exceptions, logger
│   ├── widgets/                   # Reusable widgets (loading, error states)
│   ├── services/                  # LocalStorage, HTTP services
│   └── providers/                 # Core providers (service dependencies)
│
├── features/                      # Feature-first organization
│   ├── prayer_times/
│   │   ├── data/                  # Repositories, API clients
│   │   ├── domain/                # Entities, business models
│   │   └── presentation/          # Screens, widgets, providers
│   ├── tasbih/
│   ├── names/
│   ├── quran/
│   ├── hadith/
│   └── home/
│
└── main.dart                      # App entry point
```

### Design Patterns
- **Feature-First Structure**: Each feature is self-contained
- **Repository Pattern**: Clean data access layer
- **Provider Pattern**: Dependency injection via Riverpod
- **Result<T> Pattern**: Type-safe error handling
- **State Notifier**: Complex mutable state management

---

## 🚀 Tech Stack

### Core
- **Flutter** 3.0+ - Cross-platform framework
- **Dart** 3.0+ - Programming language

### State Management
- **flutter_riverpod** ^2.4.0 - Reactive state management

### Storage & Data
- **hive** ^2.2.3 - Local NoSQL database
- **hive_flutter** ^1.1.0 - Hive Flutter integration
- **http** ^1.1.0 - HTTP client for API calls

### Utilities
- **intl** ^0.18.0 - Internationalization and date formatting

### Dev Dependencies
- **build_runner** - Code generation
- **hive_generator** - Hive type adapters
- **flutter_lints** - Linting rules

---

## 🎯 Getting Started

### Prerequisites
- Flutter SDK 3.0 or higher
- Dart SDK 3.0 or higher
- Chrome (for web testing) or Android/iOS emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/iman.git
   cd iman
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For Chrome (web)
   flutter run -d chrome --web-port=8080
   
   # For Android
   flutter run -d android
   
   # For iOS
   flutter run -d ios
   
   # For Linux desktop
   flutter run -d linux
   ```

### Building for Production

```bash
# Web
flutter build web --release

# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

---

## 📱 Screenshots

> Add screenshots of your app here

---

## 🧪 Code Quality

### Running Tests
```bash
flutter test
```

### Code Analysis
```bash
flutter analyze
```

### Format Code
```bash
dart format lib/
```

---

## 🗂️ Key Components

### Riverpod Providers
- **Provider**: Immutable dependencies (repositories, services)
- **FutureProvider**: Async data fetching (Prayer Times API)
- **StateNotifierProvider**: Complex state (Dhikr CRUD, counters)
- **StateProvider**: Simple mutable state (search queries, language selection)
- **Provider.family**: Parameterized providers (individual counters)

### Core Services
- **LocalStorageService**: Abstracts Hive operations
- **HttpService**: Centralized HTTP client with error handling
- **Result<T>**: Type-safe success/failure pattern

---

## 🔄 State Management Examples

### Simple State
```dart
final searchQueryProvider = StateProvider<String>((ref) => '');
```

### Async Data
```dart
final prayerTimesProvider = FutureProvider<PrayerTimes>((ref) async {
  final repository = ref.watch(prayerTimesRepositoryProvider);
  return repository.fetchPrayerTimes();
});
```

### Complex State
```dart
final dhikrListProvider = StateNotifierProvider<DhikrNotifier, List<Dhikr>>((ref) {
  return DhikrNotifier(ref.watch(dhikrRepositoryProvider));
});
```

---

## 📚 Data Sources

### Prayer Times API
- **Source**: Muslim World League API
- **Endpoint**: `https://api.aladhan.com/v1/timingsByCity`
- **Method**: City-based calculation

### Hadith Collection
- **Source**: Sahih Bukhari
- **Languages**: Arabic, English (Sahih International), Bangla
- **Format**: Structured JSON data

### Quran Text
- **Complete**: 114 surahs with verses
- **Languages**: Arabic, English, Bangla translations

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `flutter_lints` rules
- Keep widgets under 200 lines
- Write meaningful commit messages

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Prayer Times API by [Aladhan](https://aladhan.com/)
- Hadith translations from various authentic sources
- Quran translations from authorized sources
- Islamic content verified for authenticity

---

## 📧 Contact

**Project Maintainer**: Your Name  
**Email**: your.email@example.com  
**GitHub**: [@yourusername](https://github.com/yourusername)

---

## 🗺️ Roadmap

### Completed ✅
- [x] Clean architecture refactor
- [x] Riverpod state management
- [x] Modern UI/UX design
- [x] All 6 core features implemented

### Future Enhancements 🔮
- [ ] Qibla compass feature
- [ ] Multiple hadith collections (Muslim, Tirmidhi)
- [ ] Advanced search across Quran/Hadith
- [ ] Prayer time notifications
- [ ] Dark mode support
- [ ] Offline mode optimization
- [ ] Unit & widget tests
- [ ] CI/CD pipeline

---

**Made with ❤️ for the Muslim community**
