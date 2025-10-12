# Лабораторная работа по сетевой безопасности

## Описание
Данная лабораторная работа демонстрирует настройку и тестирование систем обнаружения вторжений (IDS) и предотвращения атак на примере Suricata и Fail2Ban.

## Подготовка системы

### Защищаемая система
- **ОС**: Ubuntu 22.04.5 LTS
- **IP-адрес**: 10.128.0.8
- **Установленные компоненты**:
  - Suricata 6.0.4 (IDS/IPS)
  - Fail2Ban 0.11.2 (защита от брутфорс атак)
  - SSH сервер (OpenSSH 8.9p1)

### Система злоумышленника
- **IP-адрес**: 10.128.0.8 (та же система для демонстрации)
- **Установленные инструменты**:
  - nmap 7.80 (сетевой сканер)
  - hydra 9.2 (инструмент для брутфорс атак)

## Задание 1: Разведка системы

### Выполненные команды nmap:

#### 1. TCP ACK scan (-sA)
```bash
sudo nmap -sA 10.128.0.8
```
**Результат**: Все 1000 портов показаны как unfiltered (не фильтруются)

#### 2. TCP connect scan (-sT)
```bash
sudo nmap -sT 10.128.0.8
```
**Результат**: Обнаружен открытый порт 22/tcp (SSH)

#### 3. TCP SYN scan (-sS)
```bash
sudo nmap -sS 10.128.0.8
```
**Результат**: Обнаружен открытый порт 22/tcp (SSH)

#### 4. Version detection scan (-sV)
```bash
sudo nmap -sV 10.128.0.8
```
**Результат**: 
- Порт 22/tcp: SSH (OpenSSH 8.9p1 Ubuntu 3ubuntu0.13)
- Операционная система: Linux

### Анализ логов после разведки:

**Suricata**: Логи пусты - сканирование nmap не было обнаружено как атака
**Fail2Ban**: Обнаружены предыдущие попытки подключения к SSH от внешних IP-адресов:
- 209.14.2.218
- 2.57.121.112  
- 77.91.82.170
- 103.93.201.42

## Задание 2: Атака на подбор пароля SSH

### Подготовка файлов для атаки:

**users.txt**:
```
msfadmin
root
admin
user
test
administrator
guest
ubuntu
```

**pass.txt**:
```
password
123456
admin
root
msfadmin
test
password123
letmein
qwerty
12345
```

### Попытка атаки с помощью hydra:
```bash
hydra -L users.txt -P pass.txt 10.128.0.8 ssh
```

**Результат**: Атака не удалась из-за настроек SSH (только ключевая аутентификация)

### Симуляция атаки:
Создан скрипт для симуляции множественных попыток подключения с неверными учетными данными:

```bash
#!/bin/bash
for i in {1..15}; do
    timeout 3 ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null -o PasswordAuthentication=yes \
        -l attacker 10.128.0.8 "exit" 2>/dev/null || true
    sleep 1
done
```

## Анализ результатов

### Логи Fail2Ban:
```
2025-10-12 07:36:23,922 fail2ban.filter [4535]: INFO [sshd] Found 10.128.0.8 - 2025-10-12 07:36:23
2025-10-12 07:36:25,009 fail2ban.filter [4535]: INFO [sshd] Found 10.128.0.8 - 2025-10-12 07:36:25
2025-10-12 07:36:26,096 fail2ban.filter [4535]: INFO [sshd] Found 10.128.0.8 - 2025-10-12 07:36:26
2025-10-12 07:36:27,189 fail2ban.filter [4535]: INFO [sshd] Found 10.128.0.8 - 2025-10-12 07:36:27
2025-10-12 07:36:28,321 fail2ban.filter [4535]: INFO [sshd] Found 10.128.0.8 - 2025-10-12 07:36:28
2025-10-12 07:36:28,701 fail2ban.actions [4535]: NOTICE [sshd] Ban 10.128.0.8
```

### Логи SSH:
```
Oct 12 07:36:25 test sshd[5828]: Invalid user attacker from 10.128.0.8 port 54382
Oct 12 07:36:25 test sshd[5828]: Connection closed by invalid user attacker 10.128.0.8 port 54382 [preauth]
Oct 12 07:36:26 test sshd[5839]: Invalid user attacker from 10.128.0.8 port 48570
Oct 12 07:36:26 test sshd[5839]: Connection closed by invalid user attacker 10.128.0.8 port 48570 [preauth]
Oct 12 07:36:27 test sshd[5846]: Invalid user attacker from 10.128.0.8 port 48576
Oct 12 07:36:27 test sshd[5846]: Connection closed by invalid user attacker 10.128.0.8 port 48576 [preauth]
Oct 12 07:36:28 test sshd[5858]: Invalid user attacker from 10.128.0.8 port 48588
Oct 12 07:36:28 test sshd[5858]: Connection closed by invalid user attacker 10.128.0.8 port 48588 [preauth]
```

### Статус Fail2Ban после атаки:
```
Status for the jail: sshd
|- Filter
|  |- Currently failed: 4
|  |- Total failed: 9
|  `- File list: /var/log/auth.log
`- Actions
   |- Currently banned: 1
   |- Total banned: 1
   `- Banned IP list: 10.128.0.8
```

## Выводы

### Задание 1 (Разведка):
1. **Suricata** не обнаружил сканирование nmap как подозрительную активность
2. **Fail2Ban** показал исторические попытки атак на SSH от внешних IP-адресов
3. Nmap успешно определил открытый SSH порт и версию службы
4. Различные типы сканирования (sA, sT, sS, sV) дали разные результаты

### Задание 2 (Брутфорс атака):
1. **Fail2Ban** эффективно обнаружил множественные попытки подключения с неверными учетными данными
2. После 5 неудачных попыток в течение 10 минут IP-адрес был заблокирован на 10 минут
3. **Suricata** не зафиксировал события в логах (возможно, правила не настроены для SSH атак)
4. SSH сервер корректно логировал все попытки подключения с несуществующим пользователем

### Рекомендации по улучшению безопасности:
1. Настроить правила Suricata для обнаружения сканирования портов
2. Ужесточить настройки Fail2Ban (уменьшить количество попыток, увеличить время блокировки)
3. Отключить аутентификацию по паролю SSH, использовать только ключи
4. Настроить мониторинг и алерты для критических событий безопасности

## Файлы проекта
- `users.txt` - список пользователей для атаки
- `pass.txt` - список паролей для атаки  
- `simulate_attack.sh` - скрипт симуляции атаки
- `README.md` - данный отчет
