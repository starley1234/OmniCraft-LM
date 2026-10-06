#!/usr/bin/env bash
# Разовая проверка живого демо: один wire-запрос через API.
set -u
curl -s -m 300 -X POST "http://127.0.0.1:${1:-8035}/api/generate" \
  -H 'Content-Type: application/json' \
  --data '{"prompt":"ферма Пратта 300x40x80 мм из круглых стержней","layer":"wire","max_new_tokens":512}' \
  | head -c 800
echo
