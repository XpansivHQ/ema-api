IMAGE=xpansiv.jfrog.io/default-docker-virtual/api-tools:v1.1

OPENAPI_OUT_DIR=openapi

export REVISION=${1:-0}
export FULL_VERSION=1.0.${REVISION}


mkdir -p ${OPENAPI_OUT_DIR}
set -x

docker_cmd="docker run --rm  -v $PWD:/usr/src/app -w /usr/src/app $IMAGE"

$docker_cmd \
   protoc -I /usr/local/include/protos -I /usr/src/app/src \
   --openapiv2_out /usr/src/app/${OPENAPI_OUT_DIR} --openapiv2_opt logtostderr=true  \
   xpansiv/ema-admin-api.proto

$docker_cmd \
   jq --arg version $FULL_VERSION '.info.version = $version' openapi/xpansiv/ema-admin-api.swagger.json > openapi/xpansiv/ema-admin-api.swagger.tmp.json
cp openapi/xpansiv/ema-admin-api.swagger.tmp.json openapi/xpansiv/ema-admin-api.swagger.json
cp openapi/xpansiv/ema-admin-api.swagger.tmp.json openapi/xpansiv/ema-admin-api.${FULL_VERSION}.json
git add openapi/xpansiv/ema-admin-api.${FULL_VERSION}.json
