#!/usr/bin/env bash

if [[ -z "$1" ]]; then
  echo -e "
Usage: run-serverless.sh COMMAND [environment]

Runs serverless with COMMAND to the given environment, assuming HUBS_OPS_PATH has the repo managing the requisite terraform resources.

To deploy outside of Hubs infrastructure, just use sls deploy.
"
  exit 1
fi

if [[ -z "$HUBS_OPS_PATH" ]]; then
  echo -e "To use this deploy script, you need to clone out the hubs-ops repo

git clone git@github.com:mozilla/hubs-ops.git

Then set HUBS_OPS_PATH to point to the cloned repo."
  exit 1
fi


COMMAND=$1
ENVIRONMENT=$2
[[ -z "$ENVIRONMENT" ]] && ENVIRONMENT=dev

DIR=$(pwd)
pushd $HUBS_OPS_PATH/terraform
# This command must be used to install a lambda-compatible version of sharp
./grunt_local.sh output nearspark $ENVIRONMENT -json | jq 'with_entries(.value |= .value)' > $DIR/config.json
popd
mv node_modules node_modules_tmp
env npm_config_arch=x64 npm_config_platform=linux npm_config_target=14.18.1 npm install --save sharp
sls $COMMAND --stage $ENVIRONMENT
rm -rf node_modules
mv node_modules_tmp node_modules
rm config.json
