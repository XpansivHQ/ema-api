EMA API
---

This project supports defining API via protobufs for simplicity of development and then
generates versioned OpenAPI specifications. It gets published via GitHUB pages

Updatind API spec
---

Make necessary changes to API and then

    ./build.sh <version>
    git commit -a -m 'api updates'
