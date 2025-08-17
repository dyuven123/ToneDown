#!/bin/bash

# Скрипт для проверки локализации в проекте ToneDown
# Запускать из корневой папки проекта

echo "🔍 Проверка локализации проекта ToneDown"
echo "=========================================="

# Проверка хардкода русских строк в UI
echo ""
echo "📱 Поиск хардкода русских строк в UI:"
echo "----------------------------------------"
if grep -r 'Text("[^"]*[а-яё][^"]*")' ToneDown/Features/ --include="*.swift" 2>/dev/null; then
    echo "❌ Найдены хардкод русские строки в UI!"
else
    echo "✅ Хардкод русских строк в UI не найден"
fi

# Проверка хардкода английских строк в UI
echo ""
echo "🌍 Поиск хардкода английских строк в UI:"
echo "------------------------------------------"
if grep -r 'Text("[^"]*[A-Za-z][^"]*")' ToneDown/Features/ --include="*.swift" 2>/dev/null | grep -v "LocalizedStringKey"; then
    echo "❌ Найдены хардкод английские строки в UI!"
else
    echo "✅ Хардкод английских строк в UI не найден"
fi

# Проверка нелокализованных строк
echo ""
echo "🔤 Поиск нелокализованных строк:"
echo "----------------------------------"
if grep -r 'Text("[^"]*")' ToneDown/Features/ --include="*.swift" 2>/dev/null | grep -v "LocalizedStringKey" | grep -v "systemName"; then
    echo "❌ Найдены нелокализованные строки!"
else
    echo "✅ Все строки используют локализацию"
fi

# Проверка синхронизации ключей
echo ""
echo "🔑 Проверка синхронизации ключей локализации:"
echo "----------------------------------------------"

# Получаем все ключи из русского файла
ru_keys=$(grep '^"[^"]*" = ' ToneDown/ru.lproj/Localizable.strings | sed 's/^"\([^"]*\)".*/\1/' | sort)

# Получаем все ключи из английского файла
en_keys=$(grep '^"[^"]*" = ' ToneDown/en.lproj/Localizable.strings | sed 's/^"\([^"]*\)".*/\1/' | sort)

# Находим ключи, которые есть только в русском файле
missing_in_en=$(comm -23 <(echo "$ru_keys") <(echo "$en_keys"))

# Находим ключи, которые есть только в английском файле
missing_in_ru=$(comm -13 <(echo "$ru_keys") <(echo "$en_keys"))

if [ -n "$missing_in_en" ]; then
    echo "❌ Ключи, отсутствующие в английском файле:"
    echo "$missing_in_en"
else
    echo "✅ Все русские ключи есть в английском файле"
fi

if [ -n "$missing_in_ru" ]; then
    echo "❌ Ключи, отсутствующие в русском файле:"
    echo "$missing_in_ru"
else
    echo "✅ Все английские ключи есть в русском файле"
fi

# Подсчет общего количества ключей
ru_count=$(echo "$ru_keys" | wc -l)
en_count=$(echo "$en_keys" | wc -l)

echo ""
echo "📊 Статистика:"
echo "---------------"
echo "Ключей в русском файле: $ru_count"
echo "Ключей в английском файле: $en_count"

if [ "$ru_count" -eq "$en_count" ]; then
    echo "✅ Количество ключей совпадает"
else
    echo "❌ Количество ключей не совпадает"
fi

echo ""
echo "🎯 Рекомендации:"
echo "-----------------"
echo "1. Всегда используйте LocalizedStringKey() для UI строк"
echo "2. Добавляйте ключи в оба файла локализации"
echo "3. Используйте осмысленные имена ключей (feature.section.element)"
echo "4. Проверяйте этот скрипт перед каждым коммитом"
echo ""
echo "📖 Подробные правила: LOCALIZATION_RULES.md"
