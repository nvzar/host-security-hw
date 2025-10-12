#!/bin/bash
# Скрипт для подготовки проекта к отправке на GitHub

echo "Инициализация Git репозитория..."

# Инициализация Git (если не инициализирован)
if [ ! -d ".git" ]; then
    git init
    echo "Git репозиторий инициализирован"
else
    echo "Git репозиторий уже существует"
fi

# Создание .gitignore
cat > .gitignore << 'GITIGNORE'
# Логи системы
*.log
/var/log/

# Временные файлы
*.tmp
*.temp
*~

# Конфиденциальные данные
users.txt
pass.txt

# Системные файлы
.DS_Store
Thumbs.db

# IDE файлы
.vscode/
.idea/
*.swp
*.swo
GITIGNORE

echo ".gitignore создан"

# Добавление файлов в репозиторий
git add README.md
git add logs_analysis.md
git add simulate_attack.sh
git add setup_git.sh
git add .gitignore

echo "Файлы добавлены в репозиторий"

# Создание первого коммита
git commit -m "Initial commit: Лабораторная работа по сетевой безопасности

- Настройка Suricata и Fail2Ban
- Тестирование nmap сканирования
- Симуляция SSH брутфорс атак
- Анализ логов систем безопасности"

echo "Первый коммит создан"

echo ""
echo "Для отправки на GitHub выполните:"
echo "1. git remote add origin <URL_вашего_репозитория>"
echo "2. git push -u origin main"
echo ""
echo "Проект готов к отправке!"
