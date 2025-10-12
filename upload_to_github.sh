#!/bin/bash
# Скрипт для загрузки проекта на GitHub

echo "🚀 Загрузка домашнего задания на GitHub"
echo "========================================"

# Проверяем статус Git
echo "📋 Текущий статус Git:"
git status --short

echo ""
echo "📦 Готовые к отправке файлы:"
git log --oneline -3

echo ""
echo "🔗 Для отправки на GitHub выполните следующие шаги:"
echo ""
echo "1️⃣ Создайте репозиторий на GitHub.com:"
echo "   - Перейдите на https://github.com/new"
echo "   - Название: network-security-lab-zarubov"
echo "   - Описание: Домашнее задание по защите сети - Зарубов Николай"
echo "   - Выберите Public или Private"
echo "   - НЕ создавайте README, .gitignore или лицензию"
echo ""
echo "2️⃣ Подключите локальный репозиторий:"
echo "   git remote add origin https://github.com/ВАШ_USERNAME/network-security-lab-zarubov.git"
echo ""
echo "3️⃣ Отправьте код:"
echo "   git push -u origin main"
echo ""
echo "📝 Структура вашего проекта:"
echo "├── Домашнее_задание_Защита_сети_Зарубов_Николай.md (основной отчет)"
echo "├── Технические_детали_Зарубов_Николай.md (технические детали)"
echo "├── Инструкции_по_сдаче.md (инструкции)"
echo "├── README.md (обзор проекта)"
echo "├── logs_analysis.md (анализ логов)"
echo "├── simulate_attack.sh (скрипт атаки)"
echo "└── setup_git.sh (настройка Git)"
echo ""
echo "✅ После успешной загрузки вы получите ссылку на репозиторий!"
