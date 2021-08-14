#!/usr/bin/env bash

echo "browse docs on http://localhost:9080"

docker run -p 9080:8080 \
    -e URLS='[{url: "xpansiv/ema-admin-api.swagger.json", name: "admin"},{url: "xpansiv/ema-registry-api.swagger.json", name: "registry"}]' \
    -v $PWD/openapi/:/openapiv2 \
    -v $PWD/openapi/xpansiv:/usr/share/nginx/html/xpansiv \
    swaggerapi/swagger-ui
