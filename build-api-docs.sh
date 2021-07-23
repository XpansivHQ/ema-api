#!/usr/bin/env bash
openapi-generator generate \
 -i openapi/ema-api.yaml \
 -g html2 \
 -o api-docs
