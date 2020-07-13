#!/bin/bash

echo Start Docker Build.....

docker rmi $(docker images -q)

$(aws ecr get-login --no-include-email --region ap-northeast-2)

docker build -t hillfolk/go-rest-api-template .

docker tag hillfolk/go-rest-api-template:latest  068261909741.dkr.ecr.ap-northeast-2.amazonaws.com/hillfolk/go-rest-api-template:latest

docker push 068261909741.dkr.ecr.ap-northeast-2.amazonaws.com/hillfolk/go-rest-api-template:latest

echo Complated Docker Build andPush .....