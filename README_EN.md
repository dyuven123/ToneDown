# ToneDown

**Make your phone less addictive with one tap**

Minimal iOS app for quick grayscale switching on iPhone through iOS Shortcuts.

## 📱 Features

- **One button** - instant grayscale mode toggle
- **Simple setup** - automatic command addition to Shortcuts
- **Quick access** - works via triple click or Back Tap
- **Premium automation** - 999₽ forever, no subscriptions ever!
- **Modern design** - light and dark theme support
- **Accessibility** - VoiceOver support

## 🎯 How it works

1. App uses **"Toggle Grayscale"** command in Shortcuts app
2. Command toggles system color filters (grayscale)
3. Can be assigned to triple click side button or Back Tap

## 📋 Requirements

- **iOS 15.0+**
- iPhone or iPad
- "Shortcuts" app (pre-installed)

## 🚀 Installation

1. Download and launch the app
2. Tap "⚙️ Setup" 
3. Tap "Add command" - opens ready command for import
4. Tap "Get command" in browser
5. **Optional**: Buy Premium automation (999₽ forever, no subscriptions!)

## ⚙️ Additional Setup

### Triple click side button:
```
Settings → Accessibility → Accessibility Shortcut → Toggle Grayscale
```

### Back Tap (double/triple tap back):
```
Settings → Accessibility → Touch → Back Tap → Shortcuts → Toggle Grayscale
```

## 💎 Premium Automation

**999₽ forever • No subscriptions ever!**

- **🕘 Automatic schedule mode** - turns on at 21:00, off at 8:00
- **📱 Smart app triggers** - automatic grayscale when opening TikTok, Instagram
- **💼 Focus modes** - integration with Work, Sleep, Do Not Disturb
- **⚡ Location triggers** - automation at work, home, gym
- **🎯 Smart rules** - set up once, works forever

## 🛠 Technical Details

**Stack:**
- SwiftUI
- iOS 15+
- Xcode 15+
- No third-party libraries

**Architecture:**
- `ToneDownApp.swift` - entry point
- `DesignSystem.swift` - colors, typography, shadows
- `ShortcutsRunner.swift` - wrapper for running commands
- `HomeView.swift` - main screen
- `SetupView.swift` - setup screen
- `LocalizationHelper.swift` - localization support

## 🎨 Design System

App uses adaptive color scheme:

- **Light theme**: #F8FAFC background, #4F46E5 accent
- **Dark theme**: automatic adaptation
- **Typography**: San Francisco system fonts
- **Accessibility**: large text and VoiceOver support

## 🌍 Localization

Supported languages:
- **English** (en)
- **Russian** (ru)

## 📦 Build

```bash
# Clone repository
git clone https://github.com/YOUR_USERNAME/ToneDown.git

# Open in Xcode
open ToneDown.xcodeproj

# Run on simulator or device
⌘ + R
```

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Create Pull Request

## 📄 License

This project is distributed under the MIT License. See `LICENSE` file for details.

## 👨‍💻 Author

Created with ❤️ for those who want to be less distracted by bright social media feeds.

---

**Note:** App uses official iOS APIs for toggling color filters through shortcuts. This is a safe and Apple-recommended approach.

