#!/bin/bash

# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -eo pipefail

export NPM_CONFIG_PREFIX=/home/node/.npm-global

cd $(dirname $0)/..

npm install
npm test
./node_modules/nyc/bin/nyc.js report


WINDOWS="false"

 case $1 in
  --windows)
    WINDOWS="true"
    ;;
  "")
    ;;
  *)
    echo "Unknown parameter: $1"
    exit 1
    ;;
  esac

if [ "$WINDOWS" != "true" ]; then
  bash $KOKORO_GFILE_DIR/codecov.sh  
fi

