# 🏗️ Архитектура проекта ToneDown

## 🤖 **ПРАВИЛО ДЛЯ AI АССИСТЕНТА:**
**При работе с проектом ToneDown ВСЕГДА следуй MVVM архитектуре!**

- ✅ **Создавай код только в правильных папках** (Models/ViewModels/Views)
- ✅ **Разделяй ответственность** между слоями
- ✅ **Используй правильные паттерны** (@Published, @StateObject)
- ✅ **НЕ создавай дублирующие определения**
- ✅ **Используй только `internal` уровень доступа**

---

## 📋 Правило: **ВСЕГДА используем MVVM архитектуру**

### 🎯 **Основные принципы:**

1. **Model (Модель)** - только данные и бизнес-логика
2. **View (Представление)** - только UI и отображение  
3. **ViewModel (Модель представления)** - состояние и действия

### 📁 **Структура папок (ОБЯЗАТЕЛЬНО соблюдать):**

```
Features/
├── FeatureName/
│   ├── Models/          ← Только модели данных
│   ├── ViewModels/      ← Только ViewModels
│   └── Views/           ← Только Views
```

### ⚠️ **ЗАПРЕЩЕНО:**

- ❌ Смешивать логику в Views
- ❌ Создавать дублирующие определения типов
- ❌ Писать бизнес-логику вне ViewModels
- ❌ Использовать `public` в одном таргете (только `internal`)

### ✅ **ОБЯЗАТЕЛЬНО:**

- ✅ Разделять ответственность между слоями
- ✅ Использовать `@Published` в ViewModels
- ✅ Связывать Views с ViewModels через `@StateObject`
- ✅ Хранить данные в Models
- ✅ Писать бизнес-логику в ViewModels

### 🔧 **Пример правильной структуры:**

```swift
// MARK: - Model
struct UserData {
    var name: String
    var email: String
}

// MARK: - ViewModel  
class UserViewModel: ObservableObject {
    @Published var userData = UserData(name: "", email: "")
    
    func updateName(_ name: String) {
        userData.name = name
    }
}

// MARK: - View
struct UserView: View {
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        Text(viewModel.userData.name)
    }
}
```

### 🚨 **При нарушении правил:**
- Код не будет принят
- Нужно переписать согласно архитектуре
- Обязательно исправить все ошибки компиляции

---

**Помните: MVVM - это не просто рекомендация, это ПРАВИЛО для проекта ToneDown!** 🎯
