# Инструкция по развертыванию домашнего задания

## Требования

- Ubuntu 22.04 LTS или аналогичная система на базе Linux
- Права администратора (sudo)
- Минимум 1 ГБ свободного места на диске

## Автоматическое выполнение

Для автоматического выполнения всех заданий используйте следующие скрипты:

### Задание 1: eCryptfs
```bash
chmod +x task1_ecryptfs.sh
./task1_ecryptfs.sh
```

### Задание 2: LUKS
```bash
chmod +x task2_luks.sh
./task2_luks.sh
```

### Задание 3: AppArmor
```bash
chmod +x task3_apparmor.sh
./task3_apparmor.sh
```

## Ручное выполнение

### Задание 1: eCryptfs

1. **Установка eCryptfs:**
   ```bash
   sudo apt update
   sudo apt install -y ecryptfs-utils
   ```

2. **Создание пользователя:**
   ```bash
   sudo adduser --disabled-password --gecos "" cryptouser
   echo "cryptouser:password123" | sudo chpasswd
   ```

3. **Шифрование домашнего каталога:**
   ```bash
   sudo ecryptfs-migrate-home -u cryptouser
   ```

### Задание 2: LUKS

1. **Установка cryptsetup:**
   ```bash
   sudo apt install -y cryptsetup
   ```

2. **Создание файла-контейнера:**
   ```bash
   sudo dd if=/dev/zero of=/tmp/luks_demo.img bs=1M count=100
   ```

3. **Шифрование:**
   ```bash
   echo "lukspassword123" | sudo cryptsetup luksFormat /tmp/luks_demo.img
   echo "lukspassword123" | sudo cryptsetup luksOpen /tmp/luks_demo.img encrypted_demo
   ```

4. **Создание файловой системы и монтирование:**
   ```bash
   sudo mkfs.ext4 /dev/mapper/encrypted_demo
   sudo mkdir -p /mnt/encrypted_demo
   sudo mount /dev/mapper/encrypted_demo /mnt/encrypted_demo
   ```

### Задание 3: AppArmor

1. **Установка AppArmor:**
   ```bash
   sudo apt install -y apparmor apparmor-utils
   ```

2. **Запуск службы:**
   ```bash
   sudo systemctl start apparmor
   sudo systemctl enable apparmor
   ```

3. **Проверка статуса:**
   ```bash
   sudo aa-status
   ```

4. **Отключение (опционально):**
   ```bash
   sudo systemctl stop apparmor
   sudo systemctl disable apparmor
   ```

## Очистка

Для удаления созданных ресурсов:

```bash
# Размонтирование LUKS контейнера
sudo umount /mnt/encrypted_demo
sudo cryptsetup luksClose encrypted_demo
sudo rm /tmp/luks_demo.img

# Удаление пользователя (опционально)
sudo userdel -r cryptouser

# Удаление AppArmor (опционально)
sudo apt remove apparmor apparmor-utils
```

## Безопасность

⚠️ **ВНИМАНИЕ:** 
- Всегда создавайте резервные копии перед шифрованием данных
- Запомните пароли для зашифрованных разделов
- Тестирование проводите на виртуальных машинах
- Не используйте слабые пароли в продакшене
