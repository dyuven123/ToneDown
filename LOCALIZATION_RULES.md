# 🗣️ Правила локализации для проекта ToneDown

## 📋 Основные принципы

### ❌ НЕ ДЕЛАТЬ
- **Хардкод русских строк** в UI коде
- **Хардкод английских строк** в UI коде  
- **Смешивание языков** в одном экране
- **Использование эмодзи** как часть локализуемого текста

### ✅ ОБЯЗАТЕЛЬНО ДЕЛАТЬ
- **Всегда использовать ключи локализации** для пользовательского интерфейса
- **Добавлять ключи в оба файла** локализации (ru.lproj и en.lproj)
- **Использовать `LocalizedStringKey()`** для SwiftUI Text
- **Использовать `LocalizationHelper.localizedString()`** для сложных случаев

## 🔧 Технические требования

### 1. Структура ключей локализации
```
"feature.section.element.type" = "Значение";
```

**Примеры:**
```swift
// ✅ Правильно
"home.button.setup" = "Настроить";
"automation.content.title" = "Автоматизация";

// ❌ Неправильно  
"button" = "Кнопка";
"title" = "Заголовок";
```

### 2. Использование в коде

#### SwiftUI Text
```swift
// ✅ Правильно
Text(LocalizedStringKey("home.button.setup"))

// ❌ Неправильно
Text("Настроить")
Text("Setup")
```

#### Сложные случаи с форматированием
```swift
// ✅ Правильно
Text(String(format: LocalizationHelper.localizedString("app.triggers.setup.step", comment: ""), currentStep + 1, setupSteps.count))

// ❌ Неправильно
Text("Шаг \(currentStep + 1) из \(setupSteps.count)")
Text("Step \(currentStep + 1) of \(setupSteps.count)")
```

### 3. Файлы локализации

#### Русский (ru.lproj/Localizable.strings)
```swift
"feature.element" = "Русский текст";
```

#### Английский (en.lproj/Localizable.strings)  
```swift
"feature.element" = "English text";
```

## 📝 Чек-лист перед коммитом

### Проверка кода
- [ ] Нет хардкода русских строк в UI
- [ ] Нет хардкода английских строк в UI
- [ ] Все строки используют ключи локализации
- [ ] Ключи добавлены в оба файла локализации

### Проверка файлов локализации
- [ ] Ключи синхронизированы между ru.lproj и en.lproj
- [ ] Нет дублирующихся ключей
- [ ] Все ключи имеют осмысленные значения
- [ ] Форматирование строк корректно (плейсхолдеры %d, %@)

## 🚨 Частые ошибки

### 1. Забыли добавить ключ в английский файл
```swift
// ❌ Только в русском файле
"new.feature" = "Новая функция";

// ✅ В обоих файлах
"new.feature" = "Новая функция";     // ru.lproj
"new.feature" = "New feature";       // en.lproj
```

### 2. Неправильное использование LocalizedStringKey
```swift
// ❌ Неправильно
Text(LocalizedStringKey("key"), param1, param2)

// ✅ Правильно для форматирования
Text(String(format: LocalizationHelper.localizedString("key"), param1, param2))
```

### 3. Эмодзи в локализуемом тексте
```swift
// ❌ Неправильно
"button.setup" = "⚙️ Настроить";

// ✅ Правильно
"button.setup" = "Настроить";
// Эмодзи добавлять в код, а не в локализацию
Text("⚙️ \(LocalizedStringKey("button.setup"))")
```

## 🔍 Поиск проблем

### Команды для поиска хардкода
```bash
# Поиск русских строк в Swift файлах
grep -r "[а-яё]" ToneDown/Features/ --include="*.swift" | grep -v "//"

# Поиск хардкода строк в UI
grep -r 'Text("[^"]*[а-яё][^"]*")' ToneDown/Features/ --include="*.swift"

# Поиск нелокализованных строк
grep -r 'Text("[^"]*")' ToneDown/Features/ --include="*.swift" | grep -v "LocalizedStringKey"
```

## 📚 Примеры правильной локализации

### Простая строка
```swift
// Код
Text(LocalizedStringKey("home.welcome"))

// ru.lproj
"home.welcome" = "Добро пожаловать";

// en.lproj  
"home.welcome" = "Welcome";
```

### Строка с параметрами
```swift
// Код
Text(String(format: LocalizationHelper.localizedString("step.progress"), current, total))

// ru.lproj
"step.progress" = "Шаг %d из %d";

// en.lproj
"step.progress" = "Step %d of %d";
```

### Кнопка с действием
```swift
// Код
Button(LocalizedStringKey("button.save")) { ... }

// ru.lproj
"button.save" = "Сохранить";

// en.lproj
"button.save" = "Save";
```

## 🎯 Цель

**100% локализация** всех пользовательских строк в приложении для поддержки:
- Русского языка (основной)
- Английского языка (тестовые сборки)
- Возможности добавления других языков в будущем

---

**Помни:** Каждая строка в UI должна быть локализована! 🚀
