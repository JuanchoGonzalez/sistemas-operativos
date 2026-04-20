#!/bin/bash

x=0

while true
do
    # Realizamos una operación aritmética para ocupar el procesador
    x=$((x + 1))
    
    # Cada 10 millones de iteraciones, imprimimos un aviso para saber que sigue vivo
    if [ $((x % 10000000)) -eq 0 ]; then
        echo "PID $$ sigue trabajando..."
        x=0 # Reseteamos para evitar desbordamientos si el script corre mucho tiempo
    fi
done
