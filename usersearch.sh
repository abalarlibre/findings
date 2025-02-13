#!/bin/bash

# URL base del blog
BASE_URL="https://www.edu.xunta.gal/centros/websdinamicas/blog/"

# Archivo para guardar los resultados
OUTPUT_FILE="usuarios.txt"

# Limpiar archivo anterior
> "$OUTPUT_FILE"

echo "🔍 Iniciando escaneo de usuarios en $BASE_URL ..."

# Iterar desde el ID 0 al 500
for i in {0..500}; do
    # Hacer petición con curl y guardar respuesta
    RESPONSE=$(curl -s -o temp.html -w "%{http_code}" "$BASE_URL/$i")

    # Si la respuesta es 200, procesar la página
    if [ "$RESPONSE" -eq 200 ]; then
        # Extraer el nombre del usuario dentro del <h1 class="title">
        USERNAME=$(grep -oP '(?<=<h1 class="title">)[^<]+' temp.html)

        # Depuración: Mostrar el nombre original detectado
        # echo "🔍 [DEBUG] ID $i - Usuario detectado: '$USERNAME'"

        # Eliminar las 2 primeras letras del nombre (quita "de")
        USERNAME="${USERNAME:9}"

        # Mostrar en terminal y guardar en archivo
        echo "✅ Usuario encontrado: ID $i - $USERNAME"
        echo "ID: $i - Usuario: $USERNAME" >> "$OUTPUT_FILE"
    fi
done

# Limpiar archivo temporal
rm -f temp.html

echo "🎯 Escaneo completado. Resultados guardados en $OUTPUT_FILE"
