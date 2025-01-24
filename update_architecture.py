#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
File: update_architecture.py
Description:
    Расширенная версия скрипта для автоматического обновления ARCHITECTURE.md,
    включая краткие описания (docstrings или комментарии) для классов/функций.
"""

import os
import re

# --- Регулярные выражения для Swift и Python ---
# Ищем объявления классов/структур/функций
SWIFT_CLASS_REGEX = r'^\s*(class|struct)\s+([A-Za-z0-9_]+)'
SWIFT_FUNC_REGEX = r'^\s*func\s+([A-Za-z0-9_]+)\('

PYTHON_CLASS_REGEX = r'^\s*class\s+([A-Za-z0-9_]+)\('
PYTHON_FUNC_REGEX = r'^\s*def\s+([A-Za-z0-9_]+)\('

# Для Swift-доков возьмём простое эвристическое правило:
# Если строка начинается с `///`, считаем это строкой документации.
SWIFT_DOC_REGEX = r'^\s*///\s*(.*)'

# Для Python docstrings будем смотреть строки после объявления.
# Ищем многострочные кавычки """...""" или '''...'''.

def parse_swift_file(file_path):
    """
    Парсим Swift-файл, чтобы извлечь классы/структуры/функции и краткие комментарии (///).
    Возвращает список словарей вида:
    [
      {
        "type": "class/struct/func",
        "name": "имя",
        "description": "текст комментария",
      },
      ...
    ]
    """
    results = []

    with open(file_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    # Пробежимся по строкам, собирая комментарии
    # (сохраняем их в буфер, пока не встретим объявление class/struct/func).
    doc_buffer = []
    
    for i, line in enumerate(lines):
        stripped = line.strip()

        # Если это строка с документирующим комментарием (///)
        doc_match = re.match(SWIFT_DOC_REGEX, line)
        if doc_match:
            doc_content = doc_match.group(1)
            doc_buffer.append(doc_content)
            continue

        # Проверяем, не является ли строка объявлением class/struct
        class_match = re.match(SWIFT_CLASS_REGEX, stripped)
        if class_match:
            cs_type = class_match.group(1)  # class или struct
            cs_name = class_match.group(2)
            # Берём всё, что накопилось в doc_buffer, как описание
            description = " ".join(doc_buffer) if doc_buffer else ""
            results.append({
                "type": cs_type,  # class / struct
                "name": cs_name,
                "description": description
            })
            doc_buffer = []  # сбрасываем буфер
            continue

        # Проверяем, не является ли строка объявлением функции
        func_match = re.match(SWIFT_FUNC_REGEX, stripped)
        if func_match:
            func_name = func_match.group(1)
            description = " ".join(doc_buffer) if doc_buffer else ""
            results.append({
                "type": "func",
                "name": func_name,
                "description": description
            })
            doc_buffer = []
            continue

        # Если строка не подходит ни под одно условие, просто идём дальше
        # и сбрасываем doc_buffer только если натолкнулись на пустую строку или другой код
        # (но для простоты здесь мы не сбрасываем, только когда находим объекты).
        # Это сделано, чтобы поддерживать многострочные /// комментарии.
    
    return results


def parse_python_file(file_path):
    """
    Парсим Python-файл для извлечения классов/функций и их docstrings (если сразу после объявления).
    Возвращает список словарей вида:
    [
      {
        "type": "class" or "def",
        "name": "имя",
        "description": "docstring",
      },
      ...
    ]
    """
    results = []

    with open(file_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    total_lines = len(lines)
    i = 0
    while i < total_lines:
        line = lines[i]
        stripped = line.strip()

        # Проверяем класс
        class_match = re.match(PYTHON_CLASS_REGEX, stripped)
        if class_match:
            class_name = class_match.group(1)
            doc_string = ""
            # Смотрим, не идёт ли на следующей строке docstring
            j = i + 1
            if j < total_lines:
                next_line = lines[j].strip()
                # Ищем многострочные кавычки
                if next_line.startswith('"""') or next_line.startswith("'''"):
                    # Начало docstring
                    doc_delimiter = next_line[:3]  # """ или '''
                    doc_content_lines = []
                    j += 1
                    # Считываем строки, пока не встретим закрывающие кавычки
                    while j < total_lines:
                        doc_line = lines[j].strip()
                        if doc_line.endswith(doc_delimiter):
                            # Последняя строка docstring
                            # берём часть строки без кавычек, если что-то есть
                            doc_line = doc_line.replace(doc_delimiter, "").strip()
                            if doc_line:
                                doc_content_lines.append(doc_line)
                            j += 1
                            break
                        else:
                            doc_content_lines.append(doc_line)
                        j += 1
                    doc_string = " ".join(doc_content_lines)
                    # Перенесём i вперёд до конца docstring
                    i = j - 1

            results.append({
                "type": "class",
                "name": class_name,
                "description": doc_string
            })

        # Проверяем функцию
        func_match = re.match(PYTHON_FUNC_REGEX, stripped)
        if func_match:
            func_name = func_match.group(1)
            doc_string = ""
            # Аналогично проверяем docstring
            j = i + 1
            if j < total_lines:
                next_line = lines[j].strip()
                if next_line.startswith('"""') or next_line.startswith("'''"):
                    doc_delimiter = next_line[:3]
                    doc_content_lines = []
                    j += 1
                    while j < total_lines:
                        doc_line = lines[j].strip()
                        if doc_line.endswith(doc_delimiter):
                            doc_line = doc_line.replace(doc_delimiter, "").strip()
                            if doc_line:
                                doc_content_lines.append(doc_line)
                            j += 1
                            break
                        else:
                            doc_content_lines.append(doc_line)
                        j += 1
                    doc_string = " ".join(doc_content_lines)
                    i = j - 1

            results.append({
                "type": "def",
                "name": func_name,
                "description": doc_string
            })

        i += 1

    return results


def main():
    root_dir = os.path.dirname(os.path.abspath(__file__))
    arch_file = os.path.join(root_dir, "ARCHITECTURE.md")

    # Данные по структуре
    structure_data = {}

    for current_path, dirs, files in os.walk(root_dir):
        # Игнорируем скрытые папки (например, .git) и вендерные папки
        if any(s.startswith('.') for s in current_path.split(os.sep)):
            continue

        rel_path = os.path.relpath(current_path, root_dir)
        if rel_path == ".":
            rel_path = "."

        # Подготавливаем запись
        if rel_path not in structure_data:
            structure_data[rel_path] = {
                "files": [],
                "details": []  # тут будем хранить информацию о классах/функциях
            }

        for file_name in files:
            # Пропускаем скрытые файлы
            if file_name.startswith('.'):
                continue

            file_path = os.path.join(current_path, file_name)
            structure_data[rel_path]["files"].append(file_name)

            if file_name.lower().endswith(".swift"):
                parsed = parse_swift_file(file_path)
                if parsed:
                    structure_data[rel_path]["details"].append({
                        "filename": file_name,
                        "lang": "swift",
                        "elements": parsed
                    })
            elif file_name.lower().endswith(".py"):
                parsed = parse_python_file(file_path)
                if parsed:
                    structure_data[rel_path]["details"].append({
                        "filename": file_name,
                        "lang": "python",
                        "elements": parsed
                    })

    # Формируем содержимое ARCHITECTURE.md
    lines = []
    #lines.append("# ARCHITECTURE.md\n")
    #lines.append("Данный файл описывает структуру проекта, файлы, а также краткие описания\n")
    #lines.append("(docstrings/комментарии) для классов, структур и функций.\n")
    #lines.append("\n## 1. Структура каталогов и список файлов\n")

    for path_key in sorted(structure_data.keys()):
        lines.append(f"### Папка: `{path_key}`")
        files_list = structure_data[path_key]["files"]
        details_list = structure_data[path_key]["details"]

        if files_list:
            lines.append("Содержимые файлы:")
            for fn in sorted(files_list):
                lines.append(f"- {fn}")
        else:
            lines.append("*(Нет файлов)*")

        # Детальная инфо о классах/функциях (Swift/Python)
        if details_list:
            lines.append("\n**Детали по файлам (Swift/Python):**")
            for detail in details_list:
                fname = detail["filename"]
                lang = detail["lang"]
                lines.append(f"- **Файл**: `{fname}` (язык: {lang})")
                for elem in detail["elements"]:
                    elem_type = elem["type"]  # class, struct, func, def
                    elem_name = elem["name"]
                    description = elem.get("description", "")
                    lines.append(f"  - {elem_type.capitalize()}: **{elem_name}**")
                    if description:
                        lines.append(f"    - *Описание:* {description}")
        lines.append("")

    #lines.append("## 2. Описание модулей и блоков\n")
    #lines.append("В этом разделе можно перечислить или вручную дополнять модули (Core, UI, Networking и т.д.)\n")
    #lines.append("и их взаимосвязи. Пример:\n")
    #lines.append("- **Core**: модели данных, бизнес-логика.\n")
    #lines.append("- **Networking**: сетевые запросы, взаимодействие с сервером.\n")
    #lines.append("- **UI**: экраны, контроллеры, View.\n")
    #lines.append("- **Services**: сервисы (аутентификация, аналитика, ...).\n")

    return lines


# Функция для обновления только части файла между маркерами
def update_architecture_md(content_lines):
    
    root_dir = os.path.dirname(os.path.abspath(__file__))
    arch_file = os.path.join(root_dir, "ARCHITECTURE.md")
    auto_gen_start = '<!-- AUTO-GENERATED-CONTENT:START -->'
    auto_gen_end = '<!-- AUTO-GENERATED-CONTENT:END -->'

    new_auto_content = "\n".join(content_lines)

    # Проверяем, существует ли файл ARCHITECTURE.md
    if os.path.exists(arch_file):
        with open(arch_file, "r", encoding="utf-8") as f:
            existing_content = f.read()
    else:
        # Если файл не существует, создаем базовый шаблон
        existing_content = f"# ARCHITECTURE.md\n\n{auto_gen_start}\n{auto_gen_end}\n"

    # Ищем маркеры в существующем контенте
    pattern = re.compile(
        r'(?P<before>.*?){start_marker}.*?{end_marker}(?P<after>.*)'.format(
            start_marker=re.escape(auto_gen_start),
            end_marker=re.escape(auto_gen_end)
        ),
        re.DOTALL
    )

    match = pattern.match(existing_content)
    if match:
        # Обновляем содержимое между маркерами
        updated_content = "{before}{start}\n{content}\n{end}{after}".format(
            before=match.group('before'),
            start=auto_gen_start,
            content=new_auto_content,
            end=auto_gen_end,
            after=match.group('after')
        )
    else:
        # Если маркеры не найдены, добавляем их в конец файла
        updated_content = existing_content + "\n{start}\n{content}\n{end}\n".format(
            start=auto_gen_start,
            content=new_auto_content,
            end=auto_gen_end
        )

    # Записываем обновленный контент в файл
    with open(arch_file, "w", encoding="utf-8") as f:
        f.write( updated_content )

    print(f"[OK] Файл ARCHITECTURE.md успешно обновлён в {arch_file}")


if __name__ == "__main__":
    lines = main( )
    update_architecture_md( lines )
