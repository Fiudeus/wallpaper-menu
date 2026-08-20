#!/bin/bash

WALL_DIR="$HOME/Pictures/Wallpapers"

# Получаем список файлов с полными путями
FILES=()
while IFS= read -r -d '' file; do
    FILES+=("$file")
done < <(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -print0)

# Если нет файлов, выходим
if [ ${#FILES[@]} -eq 0 ]; then
    echo "Файлы обоев не найдены в $WALL_DIR"
    exit 1
fi

# Создаём список для yad: полный путь + basename
YAD_LIST=()
for f in "${FILES[@]}"; do
    YAD_LIST+=("$f" "$(basename "$f")")
done

# Выбор обоев через yad
SELECTED=$(yad --title="Выбор обоев" \
    --width=500 --height=400 \
    --list \
    --column="Путь" --column="Имя файла" \
    "${YAD_LIST[@]}")

# Убираем всё после первого '|', оставляем только путь
SELECTED="${SELECTED%%|*}"

# Если выбрали файл
if [[ -n "$SELECTED" ]]; then
    FILE="$SELECTED"
    echo "Выбранный файл: $FILE"
    if [[ -f "$FILE" ]]; then
        gsettings set org.gnome.desktop.background picture-uri "file://$FILE"
        gsettings set org.gnome.desktop.background picture-uri-dark "file://$FILE"
        wal -i "$FILE"
    else
        echo "[Ошибка] Файл не найден: $FILE"
    fi
fi

