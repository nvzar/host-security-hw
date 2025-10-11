#!/bin/bash

echo "=== Задание 3*: AppArmor (дополнительное) ==="

# Устанавливаем AppArmor
echo "Устанавливаем AppArmor..."
sudo apt install -y apparmor apparmor-utils

# Проверяем статус AppArmor
echo "Проверяем статус AppArmor..."
sudo systemctl status apparmor

echo ""
echo "Проверяем профили AppArmor..."
sudo aa-status

echo ""
echo "=== Эксперимент с AppArmor ==="
echo "Создаем тестовый файл для эксперимента..."
echo "echo 'test content' | sudo tee /tmp/test_file"

echo ""
echo "=== Инструкции для отключения AppArmor ==="
echo "1. Остановите службу AppArmor:"
echo "   sudo systemctl stop apparmor"
echo ""
echo "2. Отключите автозапуск AppArmor:"
echo "   sudo systemctl disable apparmor"
echo ""
echo "3. Удалите AppArmor (опционально):"
echo "   sudo apt remove apparmor apparmor-utils"
echo ""
echo "4. Проверьте статус:"
echo "   sudo systemctl status apparmor"
