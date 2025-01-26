# ARCHITECTURE.md

Данный файл описывает структуру проекта, файлы, а также краткие описания
(docstrings/комментарии) для классов, структур и функций.


## 1. Структура каталогов и список файлов

<!-- AUTO-GENERATED-CONTENT:START -->
### Папка: `.`
Содержимые файлы:
- ARCHITECTURE.md
- AppDelegate.pdf
- Context.docx
- Context.pdf
- HomeViewController.pdf
- NetworkingService.pdf
- README.md
- SceneDelegate.pdf
- TikTok 8h MVP plan.docx
- TikTok 8h MVP plan.pdf
- UserModel and ProfileViewController.pdf
- UserModel.pdf
- VideoModel.pdf
- update_architecture.py
- ~$kTok 8h MVP plan.docx
- ~$ontext.docx

**Детали по файлам (Swift/Python):**
- **Файл**: `update_architecture.py` (язык: python)
  - Def: **parse_swift_file**
    - *Описание:* Парсим Swift-файл, чтобы извлечь классы/структуры/функции и краткие комментарии (///). Возвращает список словарей вида: [ { "type": "class/struct/func", "name": "имя", "description": "текст комментария", }, ... ]
  - Def: **parse_python_file**
    - *Описание:* Парсим Python-файл для извлечения классов/функций и их docstrings (если сразу после объявления). Возвращает список словарей вида: [ { "type": "class" or "def", "name": "имя", "description": "docstring", }, ... ]
  - Def: **main**
  - Def: **update_architecture_md**
    - *Описание:* Обновляет файл ARCHITECTURE.md, вставляя автоматически сгенерированное содержимое между спец маркерами. Если такие маркеры уже существуют, содержимое между ними будет заменено на новое. Если маркеры отсутствуют, они будут добавлены в конец файла.  Параметры: content_lines (list): Список строк с автоматически сгенерированным содержанием для вставки в файл.

### Папка: `PseudoTikTok`
*(Нет файлов)*

### Папка: `PseudoTikTok/PseudoTikTok`
Содержимые файлы:
- AppDelegate.swift
- GoogleService-Info.plist
- Info.plist
- SceneDelegate.swift
- ViewController.swift

**Детали по файлам (Swift/Python):**
- **Файл**: `ViewController.swift` (язык: swift)
  - Class: **ViewController**
- **Файл**: `AppDelegate.swift` (язык: swift)
  - Class: **AppDelegate**
  - Func: **application**
  - Func: **application**
  - Func: **application**
- **Файл**: `SceneDelegate.swift` (язык: swift)
  - Class: **SceneDelegate**
  - Func: **scene**
  - Func: **sceneDidDisconnect**
  - Func: **sceneDidBecomeActive**
  - Func: **sceneWillResignActive**
  - Func: **sceneWillEnterForeground**
  - Func: **sceneDidEnterBackground**

### Папка: `PseudoTikTok/PseudoTikTok.xcodeproj`
Содержимые файлы:
- project.pbxproj

### Папка: `PseudoTikTok/PseudoTikTok.xcodeproj/project.xcworkspace`
Содержимые файлы:
- contents.xcworkspacedata

### Папка: `PseudoTikTok/PseudoTikTok.xcodeproj/project.xcworkspace/xcshareddata`
*(Нет файлов)*

### Папка: `PseudoTikTok/PseudoTikTok.xcodeproj/project.xcworkspace/xcshareddata/swiftpm`
Содержимые файлы:
- Package.resolved

### Папка: `PseudoTikTok/PseudoTikTok.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/configuration`
*(Нет файлов)*

### Папка: `PseudoTikTok/PseudoTikTok.xcodeproj/project.xcworkspace/xcuserdata`
*(Нет файлов)*

### Папка: `PseudoTikTok/PseudoTikTok.xcodeproj/project.xcworkspace/xcuserdata/nikitakulagin.xcuserdatad`
Содержимые файлы:
- UserInterfaceState.xcuserstate

### Папка: `PseudoTikTok/PseudoTikTok.xcodeproj/xcuserdata`
*(Нет файлов)*

### Папка: `PseudoTikTok/PseudoTikTok.xcodeproj/xcuserdata/nikitakulagin.xcuserdatad`
*(Нет файлов)*

### Папка: `PseudoTikTok/PseudoTikTok.xcodeproj/xcuserdata/nikitakulagin.xcuserdatad/xcschemes`
Содержимые файлы:
- xcschememanagement.plist

### Папка: `PseudoTikTok/PseudoTikTok/Assets.xcassets`
Содержимые файлы:
- Contents.json

### Папка: `PseudoTikTok/PseudoTikTok/Assets.xcassets/AccentColor.colorset`
Содержимые файлы:
- Contents.json

### Папка: `PseudoTikTok/PseudoTikTok/Assets.xcassets/AppIcon.appiconset`
Содержимые файлы:
- Contents.json

### Папка: `PseudoTikTok/PseudoTikTok/Base.lproj`
Содержимые файлы:
- LaunchScreen.storyboard
- Main.storyboard

### Папка: `PseudoTikTok/PseudoTikTok/Core`
Содержимые файлы:
- UserModel.swift
- VideoModel.swift

**Детали по файлам (Swift/Python):**
- **Файл**: `VideoModel.swift` (язык: swift)
  - Struct: **VideoModel**
- **Файл**: `UserModel.swift` (язык: swift)
  - Struct: **User**

### Папка: `PseudoTikTok/PseudoTikTok/Networking`
Содержимые файлы:
- NetworkingService.swift

**Детали по файлам (Swift/Python):**
- **Файл**: `NetworkingService.swift` (язык: swift)
  - Class: **NetworkingService**
  - Func: **uploadVideo**
    - *Описание:* Метод для загрузки видео в Firebase Storage и сохранения информации в Firestore
  - Func: **fetchVideos**
    - *Описание:* Вспомогательный метод для сохранения информации о видео в Firestore Метод для получения списка видео из Firestore

### Папка: `PseudoTikTok/PseudoTikTok/UI`
Содержимые файлы:
- HomeViewController.swift
- MainTabBarController.swift
- ProfileViewController.swift
- VideoCell.swift

**Детали по файлам (Swift/Python):**
- **Файл**: `VideoCell.swift` (язык: swift)
  - Class: **VideoCell**
  - Func: **setupViews**
  - Func: **configure**
- **Файл**: `HomeViewController.swift` (язык: swift)
  - Class: **HomeViewController**
  - Func: **setupCollectionView**
  - Func: **loadVideos**
  - Func: **collectionView**
  - Func: **collectionView**
- **Файл**: `MainTabBarController.swift` (язык: swift)
  - Class: **MainTabBarController**
- **Файл**: `ProfileViewController.swift` (язык: swift)
  - Class: **ProfileViewController**
  - Func: **setupViews**

<!-- AUTO-GENERATED-CONTENT:END -->

## 2. Описание модулей и блоков

В этом разделе можно перечислить или вручную дополнять модули (Core, UI, Networking и т.д.)

и их взаимосвязи. Пример:

- **Core**: модели данных, бизнес-логика.

- **Networking**: сетевые запросы, взаимодействие с сервером.

- **UI**: экраны, контроллеры, View.

- **Services**: сервисы (аутентификация, аналитика, ...).

## 3. MVP Features

1. **Registration/Authentication**
2. **Feed of Videos**
3. **Ability to Upload Short Videos**
4. **Viewing and Liking Videos**

## 4. Data Models (Модели данных)

В этом разделе описываются основные сущности данных приложения.

### **User**

- `userID` (String): Уникальный идентификатор пользователя.
- `username` (String): Имя пользователя.
- `email` (String): Электронная почта.
- `profilePictureURL` (String, опционально): Ссылка на аватар пользователя.

### **Video**

- `videoID` (String): Уникальный идентификатор видео.
- `userID` (String): Идентификатор пользователя, загрузившего видео.
- `videoURL` (String): Ссылка на видео в Firebase Storage.
- `description` (String): Описание видео.
- `likesCount` (Int): Количество лайков.
- `timestamp` (Date): Время загрузки видео.

## 5. MVP Execution Plan

1. Настройка базовой структуры проекта в Xcode — 1 час
2. Подготовка UI: создание экранов и навигации — 1.5 часа
3. Реализация загрузки и отображения видео — 2 часа
4. Авторизация/Регистрация (Firebase) — 1 час
5. Базовые взаимодействия (лайки, комментарии) — 1 час
6. Тестирование и отладка MVP — 1.5 часа