#!/bin/bash -x

env
rm -rf /github/workspace/.conan/
ls -lah /github/workspace/

gunicorn -b 0.0.0.0:9300 -w 4 -t 300 conans.server.server_launcher:app &
sleep 10
conan remote add bincrafters https://api.bintray.com/conan/bincrafters/public-conan
conan remote add myremote http://localhost:9300
conan user -p demo -r myremote demo

conan profile new default --detect
conan profile update settings.compiler.libcxx=libstdc++11 default

bash -c "$INPUT_CONAN_CMD"
