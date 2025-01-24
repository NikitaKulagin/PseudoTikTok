# ARCHITECTURE.md

Данный файл описывает структуру проекта, файлы, а также краткие описания
(docstrings/комментарии) для классов, структур и функций.


## 1. Структура каталогов и список файлов

<!-- AUTO-GENERATED-CONTENT:START -->
### Папка: `.`
Содержимые файлы:
- ARCHITECTURE.md
- README.md
- update_architecture.py

**Детали по файлам (Swift/Python):**
- **Файл**: `update_architecture.py` (язык: python)
  - Def: **parse_swift_file**
    - *Описание:* Парсим Swift-файл, чтобы извлечь классы/структуры/функции и краткие комментарии (///). Возвращает список словарей вида: [ { "type": "class/struct/func", "name": "имя", "description": "текст комментария", }, ... ]
  - Def: **parse_python_file**
    - *Описание:* Парсим Python-файл для извлечения классов/функций и их docstrings (если сразу после объявления). Возвращает список словарей вида: [ { "type": "class" or "def", "name": "имя", "description": "docstring", }, ... ]
  - Def: **main**
  - Def: **update_architecture_md**

### Папка: `PseudoTikTok`
*(Нет файлов)*

### Папка: `PseudoTikTok/PseudoTikTok`
Содержимые файлы:
- AppDelegate.swift
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
*(Нет файлов)*

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
