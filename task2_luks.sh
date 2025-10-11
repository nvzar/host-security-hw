#!/bin/bash

echo "=== Задание 2: Установка LUKS и шифрование раздела ==="

# Устанавливаем cryptsetup
echo "Устанавливаем cryptsetup..."
sudo apt install -y cryptsetup

# Показываем доступные диски
echo "Доступные диски и разделы:"
lsblk

echo ""
echo "=== Инструкции для создания и шифрования раздела ==="
echo "1. Создайте раздел размером 100 МБ с помощью fdisk:"
echo "   sudo fdisk /dev/sda"
echo "   (в fdisk: n -> p -> [номер] -> [начальный сектор] -> +100M -> w)"
echo ""
echo "2. Зашифруйте раздел с помощью LUKS:"
echo "   sudo cryptsetup luksFormat /dev/sdaX"
echo "   (где X - номер созданного раздела)"
echo ""
echo "3. Откройте зашифрованный раздел:"
echo "   sudo cryptsetup luksOpen /dev/sdaX encrypted_partition"
echo ""
echo "4. Создайте файловую систему:"
echo "   sudo mkfs.ext4 /dev/mapper/encrypted_partition"
echo ""
echo "5. Создайте точку монтирования и смонтируйте:"
echo "   sudo mkdir /mnt/encrypted"
echo "   sudo mount /dev/mapper/encrypted_partition /mnt/encrypted"
echo ""
echo "6. Проверьте монтирование:"
echo "   df -h | grep encrypted"

