#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0) && pwd)

WEBHOOK_URL=https://hooks.microbadger.com/images/approximator/qt/TOslbHvKp5Rk5-rAVIFCRabn1qY=        $SCRIPT_DIR/build.sh qt
WEBHOOK_URL=https://hooks.microbadger.com/images/approximator/qbs/YAv98VYpn2tF829aRSbGUp3knIs=       $SCRIPT_DIR/build.sh qbs
WEBHOOK_URL=https://hooks.microbadger.com/images/approximator/qtcreator/TrGtR3Why-98G7-zOaUYNzM_KR8= $SCRIPT_DIR/build.sh qtcreator
WEBHOOK_URL=https://hooks.microbadger.com/images/approximator/cppcheck/bYLoFZs4A5is__cy6ENxVUd69_k=  $SCRIPT_DIR/build.sh cppcheck
WEBHOOK_URL=https://hooks.microbadger.com/images/approximator/jupyter/D0oYuf7TdKecFpa08pG-cUrS8x0=   $SCRIPT_DIR/build.sh jupyter
WEBHOOK_URL=https://hooks.microbadger.com/images/approximator/pycharm/g-6QUo2PiO3EErtM2i_MQ6PztbE=   $SCRIPT_DIR/build.sh pycharm
WEBHOOK_URL=https://hooks.microbadger.com/images/approximator/qttest/sGTa1LQ5hd_Ef9Z4eoOYrAFfo3I=    $SCRIPT_DIR/build.sh qttest
WEBHOOK_URL=https://hooks.microbadger.com/images/approximator/traviscli/-EyEPcISuXT3ZKruIVYqk6l4IsA= $SCRIPT_DIR/build.sh traviscli
