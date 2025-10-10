# 🚀 Загрузка домашнего задания на GitHub

## Быстрые действия:

### 1. Создайте репозиторий на GitHub
**Прямая ссылка:** https://github.com/new

**Настройки:**
- Repository name: `host-protection-hw`
- Description: `Домашнее задание по защите хоста - eCryptfs, LUKS, AppArmor`
- Visibility: **Public**
- ❌ НЕ добавляйте README, .gitignore или лицензию (у нас уже есть)

### 2. После создания репозитория выполните:
```bash
cd /home/msfadmin
git remote add origin https://github.com/nvzar/host-protection-hw.git
git push -u origin main
```

### 3. Альтернативный вариант (если название занято):
```bash
# Используйте любое доступное название, например:
git remote add origin https://github.com/nvzar/security-hw-$(date +%Y%m%d).git
git push -u origin main
```

## ✅ Что будет загружено:
- 📋 **README.md** (12,693 байт) - полная документация всех заданий
- 📝 **GITHUB_SETUP.md** - подробная инструкция
- 🚀 **QUICK_START.md** - краткий гайд
- ⚙️ **.gitignore** - настройки Git

## 📊 Статистика:
- **Заданий выполнено:** 3/3 ✅
- **Строк документации:** 387
- **Коммитов:** 3
- **Файлов:** 4

## 🔗 После загрузки:
Скопируйте ссылку на ваш репозиторий и отправьте преподавателю!
