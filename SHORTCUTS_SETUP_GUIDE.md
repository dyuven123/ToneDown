# Настройка команд Shortcuts для ToneDown

## Обзор системы

ToneDown использует систему счетчика grayscale для автоматического управления режимом:
- **Счетчик > 0** → Grayscale режим включен
- **Счетчик = 0** → Grayscale режим выключен

## Шаг 1: Настройка App Groups

### В Xcode:
1. Выберите ваш проект → Target → Signing & Capabilities
2. Нажмите "+ Capability" → "App Groups"
3. Добавьте группу: `group.com.tonedown.app` (замените на ваш ID)
4. Повторите для всех targets (основное приложение, расширения)

### В Shortcuts:
1. Откройте приложение Shortcuts
2. Создайте новую команду
3. Добавьте действие "Get File" → выберите "iCloud Drive" → "Shortcuts"
4. В настройках включите "App Groups" для доступа к общему хранилищу

## Шаг 2: Создание команды "Enable Grayscale"

### Структура команды:
```
1. Set Variable: automationType = "focus" (или "location", "schedule")
2. Set Variable: reason = "Focus mode activated"
3. Set Variable: action = "increment"
4. Get File: "grayscaleCounter" из App Group
5. If File Exists:
   - Get Dictionary from Input
   - Get Value for Key: "counter"
   - Calculate: counter + 1
   - Set Dictionary Value: counter = newValue
   - Save File: "grayscaleCounter" в App Group
6. Else:
   - Create Dictionary: {"counter": 1, "lastUpdate": "now"}
   - Save File: "grayscaleCounter" в App Group
7. Set Grayscale: On
8. Show Notification: "Grayscale enabled by Focus mode"
```

### Код для Shortcuts (если поддерживается):
```javascript
// Получаем текущий счетчик
let counterData = await getFile("grayscaleCounter", "App Group")
let counter = 0

if (counterData) {
    let data = JSON.parse(counterData)
    counter = data.counter || 0
}

// Увеличиваем счетчик
counter++

// Сохраняем обновленный счетчик
let newData = {
    counter: counter,
    lastUpdate: new Date().toISOString(),
    automationType: automationType,
    action: "increment",
    reason: reason
}

await saveFile("grayscaleCounter", JSON.stringify(newData), "App Group")

// Включаем grayscale
setGrayscale(true)
```

## Шаг 3: Создание команды "Disable Grayscale"

### Структура команды:
```
1. Set Variable: automationType = "focus" (или "location", "schedule")
2. Set Variable: reason = "Focus mode deactivated"
3. Set Variable: action = "decrement"
4. Get File: "grayscaleCounter" из App Group
5. If File Exists:
   - Get Dictionary from Input
   - Get Value for Key: "counter"
   - Calculate: MAX(0, counter - 1)
   - Set Dictionary Value: counter = newValue
   - Save File: "grayscaleCounter" в App Group
6. Set Grayscale: Off (если counter = 0)
7. Show Notification: "Grayscale disabled by Focus mode"
```

## Шаг 4: Настройка автоматизаций

### Focus Mode:
1. **При включении Focus:**
   - Запустить команду "Enable Grayscale"
   - Передать параметр: automationType = "focus"

2. **При выключении Focus:**
   - Запустить команду "Disable Grayscale"
   - Передать параметр: automationType = "focus"

### Location-based:
1. **При входе в зону:**
   - Запустить команду "Enable Grayscale"
   - Передать параметр: automationType = "location"

2. **При выходе из зоны:**
   - Запустить команду "Disable Grayscale"
   - Передать параметр: automationType = "location"

### Schedule:
1. **В определенное время:**
   - Запустить команду "Enable Grayscale"
   - Передать параметр: automationType = "schedule"

2. **В другое время:**
   - Запустить команду "Disable Grayscale"
   - Передать параметр: automationType = "schedule"

## Шаг 5: Тестирование

### Проверка работы:
1. Запустите команду "Enable Grayscale" вручную
2. Проверьте, что grayscale включился
3. Проверьте счетчик в вашем приложении
4. Запустите команду "Disable Grayscale"
5. Проверьте, что grayscale выключился
6. Проверьте, что счетчик уменьшился

### Отладка:
- Используйте "Show Notification" для проверки значений
- Проверьте логи в Console.app
- Убедитесь, что App Groups настроены правильно

## Важные моменты

1. **App Groups должны быть настроены в обоих приложениях**
2. **Команды должны иметь доступ к App Groups**
3. **Счетчик не должен уходить в минус**
4. **Все изменения должны логироваться**
5. **Grayscale включается/выключается только при необходимости**

## Альтернативный подход (если App Groups не работают)

Можно использовать URL Scheme для вызова вашего приложения:

```
1. Set Grayscale: On/Off
2. URL: toneDown://counter?action=increment&type=focus
3. Open URL
```

Это менее элегантно, но проще в настройке.
