#!/usr/bin/env bash

echo "browse docs on http://localhost:9080"

docker run -p 9080:8080 \
    -e SWAGGER_JSON=/openapiv2/xpansiv/ema-admin-api.swagger.json \
    -v $PWD/openapi/:/openapiv2 \
    swaggerapi/swagger-ui
