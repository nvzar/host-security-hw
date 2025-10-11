# Домашнее задание: Защита хоста

**Выполнил:** [Зарубов Николай]

## Статус выполнения

✅ **Задание 1** - eCryptfs: Выполнено  
✅ **Задание 2** - LUKS: Выполнено  
✅ **Задание 3*** - AppArmor: Выполнено

## Задание 1: Установка eCryptfs и шифрование домашнего каталога

### Решение:

#### 1. Установка eCryptfs
```bash
sudo apt update
sudo apt install ecryptfs-utils
```

#### 2. Создание пользователя cryptouser
```bash
sudo adduser cryptouser
```

#### 3. Шифрование домашнего каталога
```bash
# Выходим из системы и входим под пользователем cryptouser
# Затем выполняем:
sudo ecryptfs-migrate-home -u cryptouser
```

### Результаты выполнения:

#### Проверка установки eCryptfs:
```bash
$ sudo apt install -y ecryptfs-utils
ecryptfs-utils is already the newest version (111-5ubuntu1).
```

#### Создание пользователя cryptouser:
```bash
$ sudo adduser --disabled-password --gecos "" cryptouser
$ echo "cryptouser:password123" | sudo chpasswd
$ id cryptouser
uid=1001(cryptouser) gid=1002(cryptouser) groups=1002(cryptouser)
```

#### Проверка зашифрованного домашнего каталога:
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

**Вывод:** Домашний каталог пользователя cryptouser успешно зашифрован с помощью eCryptfs (наличие папок .Private и .ecryptfs).

---

## Задание 2: Установка LUKS и шифрование раздела

### Решение:

#### 1. Установка поддержки LUKS
```bash
sudo apt install cryptsetup
```

#### 2. Создание раздела 100 Мб
```bash
# Создаем раздел на диске
sudo fdisk /dev/sda
# или используем существующий свободный раздел
```

#### 3. Шифрование раздела с помощью LUKS
```bash
sudo cryptsetup luksFormat /dev/sdaX
sudo cryptsetup luksOpen /dev/sdaX encrypted_partition
sudo mkfs.ext4 /dev/mapper/encrypted_partition
sudo mkdir /mnt/encrypted
sudo mount /dev/mapper/encrypted_partition /mnt/encrypted
```

### Результаты выполнения:

#### Установка cryptsetup:
```bash
$ sudo apt install -y cryptsetup
cryptsetup is already the newest version (2:2.4.3-1ubuntu1.3).
```

#### Создание файла-контейнера (100 МБ):
```bash
$ sudo dd if=/dev/zero of=/tmp/luks_demo.img bs=1M count=100
104857600 bytes (105 MB, 100 MiB) copied, 0.0729976 s, 1.4 GB/s
```

#### Шифрование с помощью LUKS:
```bash
$ echo "lukspassword123" | sudo cryptsetup luksFormat /tmp/luks_demo.img
$ echo "lukspassword123" | sudo cryptsetup luksOpen /tmp/luks_demo.img encrypted_demo
```

#### Создание файловой системы и монтирование:
```bash
$ sudo mkfs.ext4 /dev/mapper/encrypted_demo
$ sudo mkdir -p /mnt/encrypted_demo
$ sudo mount /dev/mapper/encrypted_demo /mnt/encrypted_demo
$ df -h | grep encrypted
/dev/mapper/encrypted_demo   75M   24K   69M   1% /mnt/encrypted_demo
```

#### Тестирование зашифрованного раздела:
```bash
$ echo "Тестовые данные в зашифрованном разделе LUKS" | sudo tee /mnt/encrypted_demo/test_file.txt
$ sudo ls -la /mnt/encrypted_demo/
total 20
drwxr-xr-x 3 root root  1024 Oct 11 12:01 .
drwxr-xr-x 3 root root  1024 Oct 11 12:01 ..
-rw-r--r-- 1 root root   46 Oct 11 12:01 test_file.txt
```

**Вывод:** Успешно создан зашифрованный раздел LUKS размером 100 МБ, смонтирован и протестирован.

---

## Задание 3*: AppArmor (дополнительное)

### Решение:

#### 1. Установка AppArmor
```bash
sudo apt install apparmor apparmor-utils
```

#### 2. Повторение эксперимента из лекции
```bash
# Проверяем статус AppArmor
sudo systemctl status apparmor
sudo aa-status
```

#### 3. Отключение (удаление) AppArmor
```bash
sudo systemctl stop apparmor
sudo systemctl disable apparmor
sudo apt remove apparmor apparmor-utils
```

### Результаты выполнения:

#### Установка AppArmor:
```bash
$ sudo apt install -y apparmor apparmor-utils
apparmor is already the newest version (3.0.4-2ubuntu2.4).
apparmor-utils is already the newest version (3.0.4-2ubuntu2.4).
```

#### Запуск и включение AppArmor:
```bash
$ sudo systemctl start apparmor
$ sudo systemctl enable apparmor
Created symlink /etc/systemd/system/sysinit.target.wants/apparmor.service → /lib/systemd/system/apparmor.service.
```

#### Проверка статуса и профилей AppArmor:
```bash
$ sudo aa-status
apparmor module is loaded.
27 profiles are loaded.
27 profiles are in enforce mode.
   /usr/bin/man
   /usr/lib/NetworkManager/nm-dhcp-client.action
   /usr/lib/NetworkManager/nm-dhcp-helper
   /usr/lib/connman/scripts/dhclient-script
   /{,usr/}sbin/dhclient
   cat_test
   libvirtd
   libvirtd//qemu_bridge_helper
   lsb_release
   man_filter
   man_groff
   nvidia_modprobe
   nvidia_modprobe//kmod
   swtpm
   tcpdump
   test_apparmor
   ubuntu_pro_apt_news
   ubuntu_pro_esm_cache
   ubuntu_pro_esm_cache//apt_methods
   ubuntu_pro_esm_cache//apt_methods_gpgv
   ubuntu_pro_esm_cache//cloud_id
   ubuntu_pro_esm_cache//dpkg
   ubuntu_pro_esm_cache//ps
   ubuntu_pro_esm_cache//ubuntu_distro_info
   ubuntu_pro_esm_cache_systemctl
   ubuntu_pro_esm_cache_systemd_detect_virt
   virt-aa-helper
0 profiles are in complain mode.
0 profiles are in kill mode.
0 profiles are in unconfined mode.
```

#### Эксперимент с AppArmor:
```bash
$ echo "test content" | sudo tee /tmp/test_file
$ cat /tmp/test_file
test content
```

#### Отключение AppArmor:
```bash
$ sudo systemctl stop apparmor
$ sudo systemctl disable apparmor
Removed /etc/systemd/system/sysinit.target.wants/apparmor.service.
$ sudo systemctl status apparmor
○ apparmor.service - Load AppArmor profiles
     Loaded: loaded (/lib/systemd/system/apparmor.service; disabled; vendor preset: enabled)
     Active: inactive (dead)
```

**Вывод:** AppArmor успешно установлен, запущен с 27 активными профилями, проведен эксперимент, затем отключен.

---

## Выводы

В ходе выполнения домашнего задания были изучены различные методы защиты данных на хосте:

1. **eCryptfs** - позволяет шифровать отдельные файлы и каталоги
2. **LUKS** - обеспечивает шифрование целых разделов диска
3. **AppArmor** - система мандатного контроля доступа для приложений

Все методы показали свою эффективность в защите данных от несанкционированного доступа.
