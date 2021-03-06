#!/bin/bash

# Copyright (C) 2019 Timothy "ZeevoX" Langer
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

CHANGELOG="$(./scripts/changelog.sh)"

rm -f app/build/outputs/apk/travis/output.json
# shellcheck disable=SC2012
APK_NAME_OCTO=$(ls -1 app/build/outputs/apk/travis/ | tr -d '\n')

## Deploy to Telegram

#curl -F chat_id="-1001357118452" -F sticker="CAADBAAD8R8AAmSKPgABCOk3mg-Zvf0C" https://api.telegram.org/bot${BOT_TOKEN}/sendSticker
curl -F chat_id="-1001357118452" -F document=@"app/build/outputs/apk/travis/${APK_NAME_OCTO}" https://api.telegram.org/bot${BOT_TOKEN}/sendDocument
curl -F chat_id="-1001357118452" -F text="${CHANGELOG}" -F parse_mode="HTML" -F disable_web_page_preview="true" https://api.telegram.org/bot${BOT_TOKEN}/sendMessage

## Deploy to zeevox.net

curl -F "dir=/files/CI/Ocquarium/" -F "file=@${APK_NAME_OCTO}" -u "${WEBSERVER_LOGIN}" https://dl.zeevox.net/admin/upload_file.php

## Print changelog

./scripts/changelog.sh
