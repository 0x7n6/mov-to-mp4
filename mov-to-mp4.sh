#!/bin/bash

# Cek apakah FFmpeg udah diinstall
if ! command -v ffmpeg &>/dev/null; then
  echo "FFmpeg belum terinstall. Silakan install dulu pakai: brew install ffmpeg"
  exit 1
fi

# Input file dari argumen
INPUT="$1"

# Cek kalo gak ada input
if [ -z "$INPUT" ]; then
  echo "Cara pakai: ./compress_and_convert.sh namafile.mov"
  exit 1
fi

# Cek file ada atau gak
if [ ! -f "$INPUT" ]; then
  echo "File tidak ditemukan: $INPUT"
  exit 1
fi

# Ambil nama file tanpa ekstensi
FILENAME=$(basename "$INPUT" .mov)

# Output file
OUTPUT="${FILENAME}_compressed.mp4"

# Proses compress dan convert
echo "Proses compress dan convert..."
ffmpeg -i "$INPUT" -vcodec libx264 -crf 28 -preset fast -acodec aac -b:a 128k "$OUTPUT"

echo "✅ Selesai! File output: $OUTPUT"
