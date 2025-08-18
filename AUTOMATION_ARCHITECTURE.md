# Архитектура автоматизаций ToneDown

## Обзор архитектуры

ToneDown использует MVVM архитектуру для всех экранов автоматизации, обеспечивая разделение логики и представления.

## Структура файлов

```
Features/Automation/
├── Models/
│   ├── SetupStep.swift          # Модель шага настройки
│   └── AutomationState.swift    # Состояние автоматизации
├── ViewModels/
│   ├── AppTriggersSetupViewModel.swift    # VM для триггеров приложений
│   ├── ScheduleAutomationViewModel.swift  # VM для расписания
│   ├── FocusAutomationViewModel.swift     # VM для Focus режимов
│   ├── LocationAutomationViewModel.swift  # VM для геолокации
│   └── AutomationViewModel.swift          # Основной VM автоматизации
├── Views/
│   ├── AppTriggersSetupView.swift         # View для триггеров приложений
│   ├── ScheduleAutomationView.swift       # View для расписания
│   ├── FocusAutomationView.swift          # View для Focus режимов
│   ├── LocationAutomationView.swift       # View для геолокации
│   ├── AutomationView.swift               # Главный экран автоматизации
│   └── AutomationContent.swift            # Контент автоматизации
└── Components/
    ├── StepCardView.swift                 # Карточка шага
    ├── ProgressIndicatorView.swift        # Индикатор прогресса
    └── NavigationButtonsView.swift        # Кнопки навигации
```

## Модели данных

### SetupStep
```swift
struct SetupStep {
    let number: Int           // Номер шага
    let title: String         // Заголовок (ключ локализации)
    let description: String   // Описание (ключ локализации)
    let action: String        // Действие (ключ локализации)
    let icon: String          // Иконка SF Symbols
    let color: Color          // Цвет шага
    let video: String?        // Имя видео файла
}
```

### AutomationState
```swift
enum AutomationState {
    case idle                 // Начальное состояние
    case creatingCommands     // Создание команд
    case commandsCreated      // Команды созданы
    case setupCompleted       // Настройка завершена
}
```

## ViewModels

### Базовый функционал
Все ViewModels автоматизации наследуют общий функционал:

- **Управление шагами**: переход между шагами, валидация
- **Управление видео**: воспроизведение, зацикливание, пауза
- **Жизненный цикл**: обработка появления/исчезновения View
- **Состояние приложения**: обработка перехода в фон/на передний план

### Специфичный функционал
Каждый ViewModel имеет уникальные шаги настройки:

#### AppTriggersSetupViewModel
- 7 шагов для настройки триггеров приложений
- Фокус на выборе приложений и настройке триггеров

#### ScheduleAutomationViewModel
- 7 шагов для настройки расписания
- Фокус на выборе времени и настройке повторения

#### FocusAutomationViewModel
- 7 шагов для настройки Focus режимов
- Фокус на выборе режима и настройке триггеров

#### LocationAutomationViewModel
- 7 шагов для настройки геолокации
- Фокус на выборе места и настройке радиуса

## Views

### Общая структура
Все View автоматизации используют одинаковую структуру:

```swift
struct AutomationView: View {
    @StateObject private var viewModel: AutomationViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ProgressIndicatorView(...)
                StepCardView(...)
                NavigationButtonsView(...)
            }
        }
        .navigationTitle(...)
        .onAppear { viewModel.viewDidAppear() }
        .onDisappear { viewModel.viewDidDisappear() }
    }
}
```

### Компоненты
- **ProgressIndicatorView**: показывает прогресс и позволяет переходить к шагам
- **StepCardView**: отображает текущий шаг с видео и описанием
- **NavigationButtonsView**: кнопки "Назад" и "Далее"

## Локализация

### Структура ключей
```
{type}.setup.title                    # Заголовок экрана
{type}.setup.step{n}.title           # Заголовок шага
{type}.setup.step{n}.description     # Описание шага
{type}.setup.step{n}.action          # Действие шага
```

### Поддерживаемые языки
- Английский (en.lproj/Localizable.strings)
- Русский (ru.lproj/Localizable.strings)

## Управление видео

### Особенности
- Автоматическое воспроизведение при смене шага
- Зацикливание видео для непрерывной демонстрации
- Пауза при переходе приложения в фон
- Возобновление при возвращении в приложение

### Оптимизация
- Ленивая загрузка видео
- Переиспользование плееров
- Автоматическая очистка ресурсов

## Навигация

### Иерархия
```
AutomationView (главный экран)
├── AppTriggersSetupView
├── ScheduleAutomationView
├── FocusAutomationView
└── LocationAutomationView
```

### Особенности
- Каждый экран имеет собственную навигацию
- Возврат к главному экрану автоматизации
- Сохранение состояния при навигации

## Состояние и персистентность

### AppState интеграция
- Синхронизация состояния команд
- Отслеживание прогресса настройки
- Управление Premium статусом

### UserDefaults
- Сохранение статуса автоматизации
- Запоминание последней даты настройки
- Количество созданных команд

## Расширяемость

### Добавление новых типов автоматизации
1. Создать новый ViewModel с шагами
2. Создать соответствующий View
3. Добавить локализацию
4. Интегрировать в главный экран

### Модификация существующих
- Изменение шагов в ViewModel
- Обновление локализации
- Добавление новых компонентов

## Тестирование

### Unit тесты
- Валидация шагов
- Управление состоянием
- Логика навигации

### UI тесты
- Переходы между шагами
- Воспроизведение видео
- Навигация между экранами

## Производительность

### Оптимизации
- Ленивая загрузка компонентов
- Переиспользование ViewModels
- Эффективное управление памятью

### Мониторинг
- Отслеживание использования памяти
- Производительность анимаций
- Время загрузки видео
