#!/bin/bash

echo "=== Задание 1: Установка eCryptfs и шифрование домашнего каталога ==="

# Обновляем пакеты
echo "Обновляем список пакетов..."
sudo apt update

# Устанавливаем eCryptfs
echo "Устанавливаем eCryptfs..."
sudo apt install -y ecryptfs-utils

# Создаем пользователя cryptouser
echo "Создаем пользователя cryptouser..."
sudo adduser --disabled-password --gecos "" cryptouser

# Устанавливаем пароль для пользователя
echo "Устанавливаем пароль для пользователя cryptouser..."
echo "cryptouser:password123" | sudo chpasswd

echo "=== Пользователь cryptouser создан ==="
echo "Логин: cryptouser"
echo "Пароль: password123"
echo ""
echo "Для шифрования домашнего каталога выполните:"
echo "1. Выйдите из текущей сессии"
echo "2. Войдите под пользователем cryptouser"
echo "3. Выполните: sudo ecryptfs-migrate-home -u cryptouser"
echo ""
echo "ВНИМАНИЕ: Этот процесс необратим! Убедитесь, что у вас есть резервная копия данных!"
