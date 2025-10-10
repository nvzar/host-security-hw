# Быстрый старт - Загрузка на GitHub

## Вариант 1: Через веб-интерфейс GitHub

### 1. Создайте репозиторий на GitHub:
- Перейдите на https://github.com
- Нажмите "New repository"
- Название: `host-security-hw`
- Описание: `Домашнее задание по защите хоста`
- **НЕ** добавляйте README, .gitignore или лицензию
- Нажмите "Create repository"

### 2. Загрузите код:
```bash
cd /home/msfadmin
git remote add origin https://github.com/YOUR_USERNAME/host-security-hw.git
git push -u origin main
```

## Вариант 2: Через GitHub CLI (если установлен)
```bash
cd /home/msfadmin
gh repo create host-security-hw --public --source=. --remote=origin --push
```

## Вариант 3: Ручная загрузка файлов
Если Git не работает, можно загрузить файлы напрямую:
1. Создайте репозиторий на GitHub
2. Загрузите файл `README.md` через веб-интерфейс
3. Скопируйте ссылку на репозиторий

## Что получится:
- ✅ Полная документация домашнего задания
- ✅ Результаты выполнения всех заданий
- ✅ Готовый к отправке репозиторий

## Файлы для загрузки:
- `README.md` - основная документация (387 строк)
- `.gitignore` - настройки Git
- `GITHUB_SETUP.md` - подробная инструкция
