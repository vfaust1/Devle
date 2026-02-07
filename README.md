# Devle 🎮

A Wordle-inspired word guessing game built with Flutter, featuring programming-related vocabulary. Challenge yourself with daily words or play freely with random terms from the tech world!

## ✨ Features

- **Daily Word Challenge**: One word per day, synchronized for all players (locked after completion)
  - Visual **NEW** badge when available, **DONE** badge when completed
- **Free Play Mode**: Random programming terms with flexible access:
  - 3 free games per day for non-premium users
  - Watch rewarded video ads to unlock additional plays
  - Unlimited games for premium users
  - Real-time counter showing remaining free games (X/3)
- **Premium System**: 
  - One-time unlock for unlimited gameplay
  - No ads, seamless experience
  - Support ongoing development
  - Premium badge in settings
- **Rewarded Video Ads** (Mobile only):
  - Watch a short ad to play beyond daily limit
  - Integrated with Google AdMob
  - Graceful fallback on web (automatic unlock)
- **Animated Gameplay**:
  - 🎬 Smooth 3D tile flip animation on letter reveal
  - 📳 Shake effect for invalid input
  - ⏱️ Sequential tile reveal (400ms delay between letters)
- **Smart Feedback System**:
  - 🟩 Green: Letter is correct and in the right position
  - 🟨 Yellow: Letter exists but in the wrong position
  - ⬛ Grey: Letter is not in the word
- **Share Results**: Copy your score grid to clipboard with emoji tiles
- **Dictionary Validation**: Only valid words from the dictionary are accepted
- **Statistics Tracking**: Monitor your wins, win rate, current streak, and daily progress
- **Theme Toggle**: Switch between dark and light modes with persistent preference
- **Responsive Design**: Optimized for web, mobile, and desktop platforms
- **Custom Dictionary**: Curated list of programming-related terms
- **CI/CD Pipeline**: Automated testing and code quality checks via GitHub Actions

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/devle.git
cd devle
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
# For Chrome/Web
flutter run -d chrome

# For Windows
flutter run -d windows

# For mobile (with device connected)
flutter run
```

### Building for Production

#### Web
```bash
flutter build web --release
```

#### Windows
```bash
flutter build windows --release
```

#### Android
```bash
flutter build apk --release
```

#### iOS
```bash
flutter build ios --release
```

## 🎯 How to Play

1. **Choose Your Mode**:
   - Daily Word: Play today's challenge (once per day)
   - Free Word: Practice with random words (3 free games/day, unlimited for premium)

2. **Make a Guess**:
   - Enter a 5/6-letter programming term (must be in dictionary)
   - Press ENTER to submit
   - Use DEL to delete letters
   - Watch the smooth flip animation reveal your results!

3. **Read the Feedback**:
   - Green tiles indicate correct letters in correct positions
   - Yellow tiles show correct letters in wrong positions
   - Grey tiles mean the letter isn't in the word

4. **Win the Game**:
   - You have 6 attempts to guess the word
   - Track your progress in the Statistics screen
   - Share your results with the copy button!

5. **Get More Plays**:
   - Watch a short rewarded video ad (mobile only)
   - Or upgrade to Premium for unlimited games
   - Premium access available in Settings

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── screens/
│   ├── home_screen.dart      # Main menu with visual badges
│   ├── daily_word_screen.dart # Game interface with animations
│   ├── stats_screen.dart     # Statistics display
│   └── settings_screen.dart  # Theme & premium settings
├── widgets/
│   ├── flip_letter_tile.dart # Animated letter tile with 3D flip
│   ├── shake_widget.dart     # Shake animation for errors
│   ├── letter_tile.dart      # Individual letter display
│   └── key_button.dart       # Keyboard button
└── services/
    ├── word_service.dart     # Dictionary management
    ├── stats_service.dart    # Statistics & game tracking
    ├── theme_service.dart    # Theme persistence
    ├── premium_service.dart  # Premium status management
    └── ad_service.dart       # Google AdMob integration
```

## 🛠️ Technologies

- **Framework**: Flutter 3.x
- **Language**: Dart 3.x
- **State Management**: StatefulWidget with setState, ChangeNotifier
- **Monetization**: Google Mobile Ads (Rewarded Video)
- **Persistence**: shared_preferences
- **CI/CD**: GitHub Actions
- **Testing**: flutter_test, unit tests
- **Platform Support**: Web, Windows, macOS, Linux, Android, iOS

## 🧪 Testing

Run the test suite:
```bash
flutter test
```

Run code analysis:
```bash
dart analyze
```

Format code:
```bash
dart format .
```

## 📊 CI/CD

The project includes automated quality checks via GitHub Actions:
- ✅ Code formatting verification
- 🔍 Static code analysis
- 🧪 Automated test execution
- Runs on every push and pull request

## 📱 AdMob Configuration

For mobile platforms, update the AdMob App ID in:
- **Android**: `android/app/src/main/AndroidManifest.xml`
- **iOS**: `ios/Runner/Info.plist`

Current configuration uses Google's test IDs. Replace with your own IDs for production.

## 👨‍💻 Author

Made with ❤️ by Valentin Faust

## 🙏 Acknowledgments

- Inspired by the original [Wordle](https://www.nytimes.com/games/wordle/index.html) game
- Flutter community for excellent documentation and resources
