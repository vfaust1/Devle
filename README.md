# Devle 🎮

A Wordle-inspired word guessing game built with Flutter, featuring programming-related vocabulary. Challenge yourself with daily words or play freely with random terms from the tech world!

## ✨ Features

- **Daily Word Challenge**: One word per day, synchronized for all players
- **Free Play Mode**: Random programming terms (3 games/day for free users, unlimited for premium)
- **Premium System**: Unlock unlimited games and support development
- **Animated Gameplay**:
  - 🎬 Smooth tile flip animation on letter reveal
  - 📳 Shake effect for invalid input
  - ⏱️ Sequential tile reveal (400ms delay)
- **Smart Feedback System**:
  - 🟩 Green: Letter is correct and in the right position
  - 🟨 Yellow: Letter exists but in the wrong position
  - ⬛ Grey: Letter is not in the word
- **Share Results**: Copy your score grid to clipboard with emoji tiles
- **Dictionary Validation**: Only valid words from the dictionary are accepted
- **Statistics Tracking**: Monitor your wins, win rate, and current streak
- **Theme Toggle**: Switch between dark and light modes
- **Responsive Design**: Optimized for web, mobile, and desktop platforms
- **Custom Dictionary**: Curated list of programming-related terms

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

5. **Go Premium** (Optional):
   - Unlock unlimited Free Word games
   - Support the developer
   - Access available in Settings

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── screens/
│   ├── home_screen.dart      # Main menu
│   ├── daily_word_screen.dart # Game interface
│   ├── stats_screen.dart     # Statistics display
│   └── settings_screen.dart  # Theme & settings
├── widgets/
│   ├── flip_letter_tile.dart # Animated letter tile with flip effect
│   ├── shake_widget.dart     # Shake animation for errors
│   ├── letter_tile.dart      # Individual letter display
│   └── key_button.dart       # Keyboard button
└── services/
    ├── word_service.dart     # Dictionary management
    ├── stats_service.dart    # Statistics persistence
    ├── theme_service.dart    # Theme management
    └── premium_service.dart  # Premium status management
```

## 🛠️ Technologies

- **Framework**: Flutter 3.x
- **Language**: Dart 3.x
- **State Management**: StatefulWidget with setState
- **Persistence**: shared_preferences
- **Platform Support**: Web, Windows, macOS, Linux, Android, iOS

## 👨‍💻 Author

Made by Valentin Faust 

## 🙏 Acknowledgments

- Inspired by the original [Wordle](https://www.nytimes.com/games/wordle/index.html) game
