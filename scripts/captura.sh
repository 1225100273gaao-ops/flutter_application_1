#!/usr/bin/env bash
nombre="$1"
titulo="$2"

if [ -z "$nombre" ] || [ -z "$titulo" ]; then
  echo "Uso: bash scripts/captura.sh nombre_archivo \"Titulo de la captura\""
  exit 1
fi

raiz="$(cd "$(dirname "$0")/.." && pwd)"

origen="$(find "$HOME/Imágenes" "$HOME/Pictures" "$HOME/Descargas" "$HOME/Downloads" -maxdepth 3 -type f -name '*.png' -mmin -15 -printf '%T@ %p\n' 2>/dev/null | sort -n | tail -1 | cut -d' ' -f2-)"

if [ -z "$origen" ]; then
  echo "No encontré ninguna captura PNG de los últimos 15 minutos en Imágenes, Pictures o Descargas."
  exit 1
fi

mkdir -p "$raiz/docs/capturas"
mv "$origen" "$raiz/docs/capturas/$nombre.png"

{
  echo ""
  echo "### $titulo"
  echo ""
  echo "![$titulo](docs/capturas/$nombre.png)"
} >> "$raiz/README.md"

echo "Captura guardada en docs/capturas/$nombre.png y agregada al README.md"
