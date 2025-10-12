#!/bin/bash
# Симуляция атаки на SSH для тестирования Fail2Ban

echo "Симуляция атаки на SSH..."

# Попытки подключения с неверными учетными данными
for i in {1..15}; do
    echo "Попытка $i..."
    timeout 3 ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
        -o PasswordAuthentication=yes \
        -l attacker 10.128.0.8 "exit" 2>/dev/null || true
    sleep 1
done

echo "Атака завершена"
