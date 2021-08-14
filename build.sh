IMAGE=xpansiv.jfrog.io/default-docker-virtual/api-tools:v1.1

OPENAPI_OUT_DIR=openapi

export REVISION=${1:-0}
export FULL_VERSION=1.0.${REVISION}


mkdir -p ${OPENAPI_OUT_DIR}
set -x

docker_cmd="docker run --rm  -v $PWD:/usr/src/app -w /usr/src/app $IMAGE"

convertToSwagger(){
  $docker_cmd \
     protoc -I /usr/local/include/protos -I /usr/src/app/src \
     --openapiv2_out /usr/src/app/${OPENAPI_OUT_DIR} \
     --openapiv2_opt logtostderr=true  \
     --openapiv2_opt generate_unbound_methods=true  \
     --openapiv2_opt fqn_for_openapi_name=true  \
     xpansiv/${1}.proto
  jq --arg version $FULL_VERSION '.info.version = $version' openapi/xpansiv/${1}.swagger.json > openapi/xpansiv/${1}.swagger.tmp.json
}

makeVersionedFile(){
  cp openapi/xpansiv/${1}.swagger.tmp.json openapi/xpansiv/${1}.swagger.json
  cp openapi/xpansiv/${1}.swagger.tmp.json openapi/xpansiv/${1}.${FULL_VERSION}.json
  git add openapi/xpansiv/${1}.${FULL_VERSION}.json

}

convertProto() {
  convertToSwagger $1
  makeVersionedFile $1
}

convertProto ema-admin-api
convertProto ema-registry-api
