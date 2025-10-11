#!/bin/bash

echo "=== Команды для загрузки на GitHub ==="
echo ""
echo "1. Создайте репозиторий на GitHub:"
echo "   - Перейдите на https://github.com/new"
echo "   - Repository name: host-protection-hw"
echo "   - Description: Домашнее задание по защите хоста - eCryptfs, LUKS, AppArmor"
echo "   - Выберите Public"
echo "   - НЕ добавляйте README, .gitignore или лицензию"
echo "   - Нажмите Create repository"
echo ""
echo "2. После создания выполните эти команды:"
echo "   git remote add origin https://github.com/nvzar/host-protection-hw.git"
echo "   git push -u origin main"
echo ""
echo "3. Или скопируйте команды из GitHub после создания репозитория"
echo ""
echo "Текущий статус репозитория:"
git status --short
echo ""
echo "Готовые к загрузке файлы:"
ls -la *.md
